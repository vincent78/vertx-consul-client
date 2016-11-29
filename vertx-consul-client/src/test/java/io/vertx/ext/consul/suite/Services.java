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
package io.vertx.ext.consul.suite;

import io.vertx.ext.consul.*;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static io.vertx.ext.consul.Utils.getAsync;
import static io.vertx.ext.consul.Utils.runAsync;

/**
 * @author <a href="mailto:ruslan.sennov@gmail.com">Ruslan Sennov</a>
 */
public class Services extends ChecksBase {

  @Test
  public void serializeService() {
    Service src = new Service()
      .setNode("node")
      .setNodeAddress("nodeAddress")
      .setId("id")
      .setName("name")
      .setTags(Arrays.asList("tag1", "tag2"))
      .setAddress("address")
      .setPort(48);
    Service restored = new Service(src.toJson());
    assertEquals(src.getNode(), restored.getNode());
    assertEquals(src.getNodeAddress(), restored.getNodeAddress());
    assertEquals(src.getId(), restored.getId());
    assertEquals(src.getName(), restored.getName());
    assertEquals(src.getTags(), restored.getTags());
    assertEquals(src.getAddress(), restored.getAddress());
    assertEquals(src.getPort(), restored.getPort());
  }

  @Test
  public void createLocalService() {
    String serviceName = "serviceName";
    ServiceOptions service = new ServiceOptions()
      .setName(serviceName)
      .setTags(Arrays.asList("tag1", "tag2"))
      .setCheckOptions(new CheckOptions().setTtl("10s"))
      .setAddress("10.0.0.1")
      .setPort(8080);
    runAsync(h -> writeClient.registerService(service, h));

    List<Service> services = getAsync(h -> writeClient.localServices(h));
    Service s = services.stream().filter(i -> "serviceName".equals(i.getName())).findFirst().get();
    String serviceId = s.getId();
    assertEquals(s.getTags().get(1), "tag2");
    assertEquals(s.getAddress(), "10.0.0.1");
    assertEquals(s.getPort(), 8080);

    List<Check> checks = getAsync(h -> writeClient.localChecks(h));
    Check c = checks.stream().filter(i -> "serviceName".equals(i.getServiceName())).findFirst().get();
    assertEquals(c.getId(), "service:serviceName");

    List<Service> nodeServices = getAsync(h -> writeClient.catalogNodeServices(nodeName, h));
    assertEquals(2, nodeServices.size());

    List<Service> nodeServicesWithKnownTag = getAsync(h -> writeClient.catalogServiceNodesWithTag(serviceName, "tag1", h));
    assertEquals(1, nodeServicesWithKnownTag.size());

    List<Service> nodeServicesWithUnknownTag = getAsync(h -> writeClient.catalogServiceNodesWithTag(serviceName, "unknownTag", h));
    assertEquals(0, nodeServicesWithUnknownTag.size());

    runAsync(h -> writeClient.deregisterService(serviceId, h));
  }

  @Test
  public void findConsul() {
    List<Service> localConsulList = getAsync(h -> writeClient.catalogServiceNodes("consul", h));
    assertEquals(localConsulList.size(), 1);
    List<Service> catalogConsulList = Utils.<List<Service>>getAsync(h -> writeClient.catalogServices(h))
      .stream().filter(s -> s.getName().equals("consul")).collect(Collectors.toList());
    assertEquals(1, catalogConsulList.size());
    assertEquals(0, catalogConsulList.get(0).getTags().size());
  }

  @Test
  public void maintenanceMode() {
    String serviceId = "serviceId";
    ServiceOptions service = new ServiceOptions()
      .setName("serviceName")
      .setId(serviceId)
      .setAddress("10.0.0.1")
      .setCheckOptions(new CheckOptions().setTtl("1h"))
      .setPort(8080);
    runAsync(h -> writeClient.registerService(service, h));
    runAsync(h -> writeClient.passCheck("service:" + serviceId, h));

    List<Check> checks = getAsync(h -> writeClient.localChecks(h));
    assertEquals(1, checks.size());

    String reason = "special symbols like `&` are allowed (хорошо)";
    MaintenanceOptions opts = new MaintenanceOptions()
      .setId(serviceId)
      .setReason(reason)
      .setEnable(true);
    runAsync(h -> writeClient.maintenanceService(opts, h));

    // TODO undocumented (?) behavior
    checks = getAsync(h -> writeClient.localChecks(h));
    assertEquals(2, checks.size());
    long cnt = checks.stream().filter(info -> info.getStatus() == CheckStatus.CRITICAL).count();
    assertEquals(1, cnt);
    assertEquals(reason, checks.get(0).getNotes());

    opts.setEnable(false);
    runAsync(h -> writeClient.maintenanceService(opts, h));

    checks = getAsync(h -> writeClient.localChecks(h));
    assertEquals(1, checks.size());

    runAsync(h -> writeClient.deregisterService(serviceId, h));
  }

  @Override
  String createCheck(CheckOptions opts) {
    String serviceId = "serviceId";
    ServiceOptions service = new ServiceOptions()
      .setName("serviceName")
      .setId(serviceId)
      .setTags(Arrays.asList("tag1", "tag2"))
      .setCheckOptions(opts)
      .setAddress("10.0.0.1")
      .setPort(8080);
    runAsync(h -> writeClient.registerService(service, h));
    return "service:" + serviceId;
  }
}