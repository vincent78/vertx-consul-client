/*
 * Copyright (c) 2016 The original author or authors
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * and Apache License v2.0 which accompanies this distribution.
 *
 *      The Eclipse Public License is available at
 *      http://www.eclipse.org/legal/epl-v10.html
 *
 *      The Apache License v2.0 is available at
 *      http://www.opensource.org/licenses/apache2.0.php
 *
 * You may elect to redistribute this code under either of these licenses.
 */
package io.vertx.ext.consul;

import com.pszymczyk.consul.ConsulProcess;
import com.pszymczyk.consul.ConsulStarterBuilder;
import com.pszymczyk.consul.LogLevel;
import io.vertx.core.Handler;
import io.vertx.core.Vertx;
import io.vertx.core.http.HttpClient;
import io.vertx.core.http.HttpClientOptions;
import io.vertx.core.json.JsonObject;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

/**
 * @author <a href="mailto:ruslan.sennov@gmail.com">Ruslan Sennov</a>
 */
class ConsulCluster {

  private static final String MASTER_TOKEN = "topSecret";
  private static final String DC = "test-dc";
  private static final String NODE_NAME = "nodeName";
  private static final String CONSUL_VERSION = "0.7.1";

  private static ConsulCluster instance;

  private static ConsulCluster instance() {
    if (instance == null) {
      synchronized (ConsulCluster.class) {
        if (instance == null) {
          instance = new ConsulCluster();
        }
      }
    }
    return instance;
  }

  static ConsulProcess consul() {
    return instance().consul;
  }

  static void close() {
    instance().consul.close();
  }

  static String dc() {
    return DC;
  }

  static String masterToken() {
    return MASTER_TOKEN;
  }

  static String writeToken() {
    return instance().writeToken;
  }

  static String readToken() {
    return instance().readToken;
  }

  static String nodeName() {
    return NODE_NAME;
  }

  private ConsulProcess consul;
  private String writeToken;
  private String readToken;

  private ConsulCluster() {
    try {
      create();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  private void create() throws Exception {
    JsonObject config = new JsonObject()
      .put("server", true)
      .put("datacenter", DC)
      .put("node_name", NODE_NAME)
      .put("acl_default_policy", "deny")
      .put("acl_master_token", MASTER_TOKEN)
      .put("acl_datacenter", DC);
    consul = ConsulStarterBuilder.consulStarter()
      .withLogLevel(LogLevel.ERR)
      .withConsulVersion(CONSUL_VERSION)
      .withCustomConfig(config.encode())
      .build()
      .start();

    CountDownLatch latch = new CountDownLatch(2);
    Vertx vertx = Vertx.vertx();
    createToken(vertx, "write_rules.hcl", token -> {
      writeToken = token;
      latch.countDown();
    });
    createToken(vertx, "read_rules.hcl", token -> {
      readToken = token;
      latch.countDown();
    });
    latch.await(10, TimeUnit.SECONDS);
    vertx.close();

    if (writeToken == null || readToken == null) {
      throw new RuntimeException("Starting consul fails " + writeToken + "/" + readToken);
    }
  }

  private void createToken(Vertx vertx, String rules, Handler<String> tokenHandler) {
    HttpClientOptions httpClientOptions = new HttpClientOptions().setDefaultPort(consul.getHttpPort());
    HttpClient httpClient = vertx.createHttpClient(httpClientOptions);
    String rulesBody;
    try {
      rulesBody = Utils.readResource(rules);
    } catch (Exception e) {
      tokenHandler.handle(null);
      return;
    }
    String request = new JsonObject()
      .put("Rules", rulesBody)
      .encode();
    httpClient.put("/v1/acl/create?token=" + MASTER_TOKEN, h -> {
      if (h.statusCode() == 200) {
        h.bodyHandler(bh -> {
          JsonObject responce = new JsonObject(bh.toString());
          httpClient.close();
          tokenHandler.handle(responce.getString("ID"));
        });
      } else {
        tokenHandler.handle(null);
      }
    }).end(request);
  }
}