# Creates a Diamond configuration file
#
#    diamond_configure node['hostname']" do
#      action :config
#      diamond_handlers [ "diamond.handler.archive.ArchiveHandler", "diamond.handler.graphite.GraphiteHandler" ]
#      graphite_handler({"host" => "127.0.0.1","port" => 2003, "timeout" => 15})
#    end

action :config do

  template new_resource.prefix + "/etc/diamond/diamond.conf" do
    source new_resource.diamond_configuration_source
    cookbook new_resource.cookbook
    mode 0644
    owner "root"
    group "root"
    variables({
                :diamond_handlers => new_resource.diamond_handlers,
                :user => new_resource.diamond_user,
                :group => new_resource.diamond_group,
                :pidfile => new_resource.diamond_pidfile,
                :collectors_path => new_resource.diamond_collectors_path,
                :collectors_config_path => new_resource.collectors_config_path,
                :reload_interval => new_resource.collectors_reload_interval,
                :archive_handler => new_resource.archive_handler,
                :graphite_handler => new_resource.graphite_handler,
                :graphite_picklehandler => new_resource.graphite_picklehandler,
                :statsdhandler => new_resource.statsdhandler,
                :mysqlhandler => new_resource.mysqlhandler,
                :tsdbhandler => new_resource.tsdbhandler,
                :collectors => new_resource.collectors,
                :prefix => new_resource.prefix
              })
    helpers(Chef::Recipe::Diamond)
  end

  template new_resource.prefix + "/etc/diamond/handlers/GraphiteHandler.conf" do
    source "generic_collector_config.conf.erb"
    cookbook "diamond"
    variables({
                :name => "GraphiteHandler",
                :options => new_resource.graphite_handler
              })
    helpers(Chef::Recipe::Diamond)
  end

  template new_resource.prefix + "/etc/diamond/handlers/GraphitePickleHandler.conf" do
    source "generic_collector_config.conf.erb"
    cookbook "diamond"
    variables({
                :name => "GraphitePickleHandler",
                :options => new_resource.graphite_picklehandler
              })
    helpers(Chef::Recipe::Diamond)
  end

  new_resource.updated_by_last_action(true)
end
