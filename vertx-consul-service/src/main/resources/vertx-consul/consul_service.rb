require 'vertx/vertx'
require 'vertx-consul/consul_client'
require 'vertx/util/utils.rb'
# Generated from io.vertx.ext.consul.ConsulService
module VertxConsul
  class ConsulService < ::VertxConsul::ConsulClient
    # @private
    # @param j_del [::VertxConsul::ConsulService] the java delegate
    def initialize(j_del)
      super(j_del)
      @j_del = j_del
    end
    # @private
    # @return [::VertxConsul::ConsulService] the underlying java delegate
    def j_del
      @j_del
    end
    @@j_api_type = Object.new
    def @@j_api_type.accept?(obj)
      obj.class == ConsulService
    end
    def @@j_api_type.wrap(obj)
      ConsulService.new(obj)
    end
    def @@j_api_type.unwrap(obj)
      obj.j_del
    end
    def self.j_api_type
      @@j_api_type
    end
    def self.j_class
      Java::IoVertxExtConsul::ConsulService.java_class
    end
    #  Create a proxy to a service that is deployed somewhere on the event bus
    # @param [::Vertx::Vertx] vertx the Vert.x instance
    # @param [String] address the address the service is listening on on the event bus
    # @return [::VertxConsul::ConsulService] the service
    def self.create_event_bus_proxy(vertx=nil,address=nil)
      if vertx.class.method_defined?(:j_del) && address.class == String && !block_given?
        return ::Vertx::Util::Utils.safe_create(Java::IoVertxExtConsul::ConsulService.java_method(:createEventBusProxy, [Java::IoVertxCore::Vertx.java_class,Java::java.lang.String.java_class]).call(vertx.j_del,address),::VertxConsul::ConsulService)
      end
      raise ArgumentError, "Invalid arguments when calling create_event_bus_proxy(#{vertx},#{address})"
    end
    # @yield 
    # @return [self]
    def agent_info
      if block_given?
        @j_del.java_method(:agentInfo, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result != nil ? JSON.parse(ar.result.encode) : nil : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling agent_info()"
    end
    # @yield 
    # @return [self]
    def coordinate_nodes
      if block_given?
        @j_del.java_method(:coordinateNodes, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling coordinate_nodes()"
    end
    # @yield 
    # @return [self]
    def coordinate_datacenters
      if block_given?
        @j_del.java_method(:coordinateDatacenters, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling coordinate_datacenters()"
    end
    # @param [String] key 
    # @yield 
    # @return [self]
    def get_value(key=nil)
      if key.class == String && block_given?
        @j_del.java_method(:getValue, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(key,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result != nil ? JSON.parse(ar.result.toJson.encode) : nil : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling get_value(#{key})"
    end
    # @param [String] key 
    # @param [Hash] options 
    # @yield 
    # @return [self]
    def get_value_blocking(key=nil,options=nil)
      if key.class == String && options.class == Hash && block_given?
        @j_del.java_method(:getValueBlocking, [Java::java.lang.String.java_class,Java::IoVertxExtConsul::BlockingQueryOptions.java_class,Java::IoVertxCore::Handler.java_class]).call(key,Java::IoVertxExtConsul::BlockingQueryOptions.new(::Vertx::Util::Utils.to_json_object(options)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result != nil ? JSON.parse(ar.result.toJson.encode) : nil : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling get_value_blocking(#{key},#{options})"
    end
    # @param [String] key 
    # @yield 
    # @return [self]
    def delete_value(key=nil)
      if key.class == String && block_given?
        @j_del.java_method(:deleteValue, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(key,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling delete_value(#{key})"
    end
    # @param [String] keyPrefix 
    # @yield 
    # @return [self]
    def get_values(keyPrefix=nil)
      if keyPrefix.class == String && block_given?
        @j_del.java_method(:getValues, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(keyPrefix,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling get_values(#{keyPrefix})"
    end
    # @param [String] keyPrefix 
    # @param [Hash] options 
    # @yield 
    # @return [self]
    def get_values_blocking(keyPrefix=nil,options=nil)
      if keyPrefix.class == String && options.class == Hash && block_given?
        @j_del.java_method(:getValuesBlocking, [Java::java.lang.String.java_class,Java::IoVertxExtConsul::BlockingQueryOptions.java_class,Java::IoVertxCore::Handler.java_class]).call(keyPrefix,Java::IoVertxExtConsul::BlockingQueryOptions.new(::Vertx::Util::Utils.to_json_object(options)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling get_values_blocking(#{keyPrefix},#{options})"
    end
    # @param [String] keyPrefix 
    # @yield 
    # @return [self]
    def delete_values(keyPrefix=nil)
      if keyPrefix.class == String && block_given?
        @j_del.java_method(:deleteValues, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(keyPrefix,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling delete_values(#{keyPrefix})"
    end
    # @param [String] key 
    # @param [String] value 
    # @yield 
    # @return [self]
    def put_value(key=nil,value=nil)
      if key.class == String && value.class == String && block_given?
        @j_del.java_method(:putValue, [Java::java.lang.String.java_class,Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(key,value,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling put_value(#{key},#{value})"
    end
    # @param [String] key 
    # @param [String] value 
    # @param [Hash] options 
    # @yield 
    # @return [self]
    def put_value_with_options(key=nil,value=nil,options=nil)
      if key.class == String && value.class == String && options.class == Hash && block_given?
        @j_del.java_method(:putValueWithOptions, [Java::java.lang.String.java_class,Java::java.lang.String.java_class,Java::IoVertxExtConsul::KeyValueOptions.java_class,Java::IoVertxCore::Handler.java_class]).call(key,value,Java::IoVertxExtConsul::KeyValueOptions.new(::Vertx::Util::Utils.to_json_object(options)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling put_value_with_options(#{key},#{value},#{options})"
    end
    # @param [Hash] token 
    # @yield 
    # @return [self]
    def create_acl_token(token=nil)
      if token.class == Hash && block_given?
        @j_del.java_method(:createAclToken, [Java::IoVertxExtConsul::AclToken.java_class,Java::IoVertxCore::Handler.java_class]).call(Java::IoVertxExtConsul::AclToken.new(::Vertx::Util::Utils.to_json_object(token)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling create_acl_token(#{token})"
    end
    # @param [Hash] token 
    # @yield 
    # @return [self]
    def update_acl_token(token=nil)
      if token.class == Hash && block_given?
        @j_del.java_method(:updateAclToken, [Java::IoVertxExtConsul::AclToken.java_class,Java::IoVertxCore::Handler.java_class]).call(Java::IoVertxExtConsul::AclToken.new(::Vertx::Util::Utils.to_json_object(token)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling update_acl_token(#{token})"
    end
    # @param [String] id 
    # @yield 
    # @return [self]
    def clone_acl_token(id=nil)
      if id.class == String && block_given?
        @j_del.java_method(:cloneAclToken, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(id,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling clone_acl_token(#{id})"
    end
    # @yield 
    # @return [self]
    def list_acl_tokens
      if block_given?
        @j_del.java_method(:listAclTokens, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling list_acl_tokens()"
    end
    # @param [String] id 
    # @yield 
    # @return [self]
    def info_acl_token(id=nil)
      if id.class == String && block_given?
        @j_del.java_method(:infoAclToken, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(id,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result != nil ? JSON.parse(ar.result.toJson.encode) : nil : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling info_acl_token(#{id})"
    end
    # @param [String] id 
    # @yield 
    # @return [self]
    def destroy_acl_token(id=nil)
      if id.class == String && block_given?
        @j_del.java_method(:destroyAclToken, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(id,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling destroy_acl_token(#{id})"
    end
    # @param [String] name 
    # @yield 
    # @return [self]
    def fire_event(name=nil)
      if name.class == String && block_given?
        @j_del.java_method(:fireEvent, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(name,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result != nil ? JSON.parse(ar.result.toJson.encode) : nil : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling fire_event(#{name})"
    end
    # @param [String] name 
    # @param [Hash] options 
    # @yield 
    # @return [self]
    def fire_event_with_options(name=nil,options=nil)
      if name.class == String && options.class == Hash && block_given?
        @j_del.java_method(:fireEventWithOptions, [Java::java.lang.String.java_class,Java::IoVertxExtConsul::EventOptions.java_class,Java::IoVertxCore::Handler.java_class]).call(name,Java::IoVertxExtConsul::EventOptions.new(::Vertx::Util::Utils.to_json_object(options)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result != nil ? JSON.parse(ar.result.toJson.encode) : nil : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling fire_event_with_options(#{name},#{options})"
    end
    # @yield 
    # @return [self]
    def list_events
      if block_given?
        @j_del.java_method(:listEvents, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling list_events()"
    end
    # @param [Hash] serviceOptions 
    # @yield 
    # @return [self]
    def register_service(serviceOptions=nil)
      if serviceOptions.class == Hash && block_given?
        @j_del.java_method(:registerService, [Java::IoVertxExtConsul::ServiceOptions.java_class,Java::IoVertxCore::Handler.java_class]).call(Java::IoVertxExtConsul::ServiceOptions.new(::Vertx::Util::Utils.to_json_object(serviceOptions)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling register_service(#{serviceOptions})"
    end
    # @param [Hash] maintenanceOptions 
    # @yield 
    # @return [self]
    def maintenance_service(maintenanceOptions=nil)
      if maintenanceOptions.class == Hash && block_given?
        @j_del.java_method(:maintenanceService, [Java::IoVertxExtConsul::MaintenanceOptions.java_class,Java::IoVertxCore::Handler.java_class]).call(Java::IoVertxExtConsul::MaintenanceOptions.new(::Vertx::Util::Utils.to_json_object(maintenanceOptions)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling maintenance_service(#{maintenanceOptions})"
    end
    # @param [String] id 
    # @yield 
    # @return [self]
    def deregister_service(id=nil)
      if id.class == String && block_given?
        @j_del.java_method(:deregisterService, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(id,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling deregister_service(#{id})"
    end
    # @param [String] service 
    # @yield 
    # @return [self]
    def catalog_service_nodes(service=nil)
      if service.class == String && block_given?
        @j_del.java_method(:catalogServiceNodes, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(service,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling catalog_service_nodes(#{service})"
    end
    # @param [String] service 
    # @param [String] tag 
    # @yield 
    # @return [self]
    def catalog_service_nodes_with_tag(service=nil,tag=nil)
      if service.class == String && tag.class == String && block_given?
        @j_del.java_method(:catalogServiceNodesWithTag, [Java::java.lang.String.java_class,Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(service,tag,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling catalog_service_nodes_with_tag(#{service},#{tag})"
    end
    # @yield 
    # @return [self]
    def catalog_datacenters
      if block_given?
        @j_del.java_method(:catalogDatacenters, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling catalog_datacenters()"
    end
    # @yield 
    # @return [self]
    def catalog_nodes
      if block_given?
        @j_del.java_method(:catalogNodes, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling catalog_nodes()"
    end
    # @yield 
    # @return [self]
    def catalog_services
      if block_given?
        @j_del.java_method(:catalogServices, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling catalog_services()"
    end
    # @yield 
    # @return [self]
    def local_services
      if block_given?
        @j_del.java_method(:localServices, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling local_services()"
    end
    # @param [String] node 
    # @yield 
    # @return [self]
    def catalog_node_services(node=nil)
      if node.class == String && block_given?
        @j_del.java_method(:catalogNodeServices, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(node,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling catalog_node_services(#{node})"
    end
    # @yield 
    # @return [self]
    def local_checks
      if block_given?
        @j_del.java_method(:localChecks, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling local_checks()"
    end
    # @param [Hash] checkOptions 
    # @yield 
    # @return [self]
    def register_check(checkOptions=nil)
      if checkOptions.class == Hash && block_given?
        @j_del.java_method(:registerCheck, [Java::IoVertxExtConsul::CheckOptions.java_class,Java::IoVertxCore::Handler.java_class]).call(Java::IoVertxExtConsul::CheckOptions.new(::Vertx::Util::Utils.to_json_object(checkOptions)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling register_check(#{checkOptions})"
    end
    # @param [String] checkId 
    # @yield 
    # @return [self]
    def deregister_check(checkId=nil)
      if checkId.class == String && block_given?
        @j_del.java_method(:deregisterCheck, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(checkId,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling deregister_check(#{checkId})"
    end
    # @param [String] checkId 
    # @yield 
    # @return [self]
    def pass_check(checkId=nil)
      if checkId.class == String && block_given?
        @j_del.java_method(:passCheck, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(checkId,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling pass_check(#{checkId})"
    end
    # @param [String] checkId 
    # @param [String] note 
    # @yield 
    # @return [self]
    def pass_check_with_note(checkId=nil,note=nil)
      if checkId.class == String && note.class == String && block_given?
        @j_del.java_method(:passCheckWithNote, [Java::java.lang.String.java_class,Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(checkId,note,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling pass_check_with_note(#{checkId},#{note})"
    end
    # @param [String] checkId 
    # @yield 
    # @return [self]
    def warn_check(checkId=nil)
      if checkId.class == String && block_given?
        @j_del.java_method(:warnCheck, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(checkId,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling warn_check(#{checkId})"
    end
    # @param [String] checkId 
    # @param [String] note 
    # @yield 
    # @return [self]
    def warn_check_with_note(checkId=nil,note=nil)
      if checkId.class == String && note.class == String && block_given?
        @j_del.java_method(:warnCheckWithNote, [Java::java.lang.String.java_class,Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(checkId,note,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling warn_check_with_note(#{checkId},#{note})"
    end
    # @param [String] checkId 
    # @yield 
    # @return [self]
    def fail_check(checkId=nil)
      if checkId.class == String && block_given?
        @j_del.java_method(:failCheck, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(checkId,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling fail_check(#{checkId})"
    end
    # @param [String] checkId 
    # @param [String] note 
    # @yield 
    # @return [self]
    def fail_check_with_note(checkId=nil,note=nil)
      if checkId.class == String && note.class == String && block_given?
        @j_del.java_method(:failCheckWithNote, [Java::java.lang.String.java_class,Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(checkId,note,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling fail_check_with_note(#{checkId},#{note})"
    end
    # @param [String] checkId 
    # @param [:PASSING,:WARNING,:CRITICAL] status 
    # @yield 
    # @return [self]
    def update_check(checkId=nil,status=nil)
      if checkId.class == String && status.class == Symbol && block_given?
        @j_del.java_method(:updateCheck, [Java::java.lang.String.java_class,Java::IoVertxExtConsul::CheckStatus.java_class,Java::IoVertxCore::Handler.java_class]).call(checkId,Java::IoVertxExtConsul::CheckStatus.valueOf(status),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling update_check(#{checkId},#{status})"
    end
    # @param [String] checkId 
    # @param [:PASSING,:WARNING,:CRITICAL] status 
    # @param [String] note 
    # @yield 
    # @return [self]
    def update_check_with_note(checkId=nil,status=nil,note=nil)
      if checkId.class == String && status.class == Symbol && note.class == String && block_given?
        @j_del.java_method(:updateCheckWithNote, [Java::java.lang.String.java_class,Java::IoVertxExtConsul::CheckStatus.java_class,Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(checkId,Java::IoVertxExtConsul::CheckStatus.valueOf(status),note,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling update_check_with_note(#{checkId},#{status},#{note})"
    end
    # @yield 
    # @return [self]
    def leader_status
      if block_given?
        @j_del.java_method(:leaderStatus, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling leader_status()"
    end
    # @yield 
    # @return [self]
    def peers_status
      if block_given?
        @j_del.java_method(:peersStatus, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling peers_status()"
    end
    # @yield 
    # @return [self]
    def create_session
      if block_given?
        @j_del.java_method(:createSession, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling create_session()"
    end
    # @param [Hash] options 
    # @yield 
    # @return [self]
    def create_session_with_options(options=nil)
      if options.class == Hash && block_given?
        @j_del.java_method(:createSessionWithOptions, [Java::IoVertxExtConsul::SessionOptions.java_class,Java::IoVertxCore::Handler.java_class]).call(Java::IoVertxExtConsul::SessionOptions.new(::Vertx::Util::Utils.to_json_object(options)),(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling create_session_with_options(#{options})"
    end
    # @param [String] id 
    # @yield 
    # @return [self]
    def info_session(id=nil)
      if id.class == String && block_given?
        @j_del.java_method(:infoSession, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(id,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result != nil ? JSON.parse(ar.result.toJson.encode) : nil : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling info_session(#{id})"
    end
    # @param [String] id 
    # @yield 
    # @return [self]
    def renew_session(id=nil)
      if id.class == String && block_given?
        @j_del.java_method(:renewSession, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(id,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result != nil ? JSON.parse(ar.result.toJson.encode) : nil : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling renew_session(#{id})"
    end
    # @yield 
    # @return [self]
    def list_sessions
      if block_given?
        @j_del.java_method(:listSessions, [Java::IoVertxCore::Handler.java_class]).call((Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling list_sessions()"
    end
    # @param [String] nodeId 
    # @yield 
    # @return [self]
    def list_node_sessions(nodeId=nil)
      if nodeId.class == String && block_given?
        @j_del.java_method(:listNodeSessions, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(nodeId,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil, ar.succeeded ? ar.result.to_a.map { |elt| elt != nil ? JSON.parse(elt.toJson.encode) : nil } : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling list_node_sessions(#{nodeId})"
    end
    # @param [String] id 
    # @yield 
    # @return [self]
    def destroy_session(id=nil)
      if id.class == String && block_given?
        @j_del.java_method(:destroySession, [Java::java.lang.String.java_class,Java::IoVertxCore::Handler.java_class]).call(id,(Proc.new { |ar| yield(ar.failed ? ar.cause : nil) }))
        return self
      end
      raise ArgumentError, "Invalid arguments when calling destroy_session(#{id})"
    end
    # @return [void]
    def close
      if !block_given?
        return @j_del.java_method(:close, []).call()
      end
      raise ArgumentError, "Invalid arguments when calling close()"
    end
  end
end