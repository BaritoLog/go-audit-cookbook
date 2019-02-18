#
# Cookbook:: go-audit
# Recipe:: default
#
# Copyright:: 2019, BaritoLog.
#
#

service_name = node[cookbook_name]['service_name']

go_audit_service_account node[cookbook_name]['user'] do
  service_group node[cookbook_name]['group']
end

package %w(auditd)

go_audit_binary_install service_name do
  version node[cookbook_name]['version']
  prefix_root node[cookbook_name]['prefix_root']
  prefix_bin node[cookbook_name]['prefix_bin']
  prefix_temp node[cookbook_name]['prefix_temp']
  mirror node[cookbook_name]['mirror']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

env_vars_file = node[cookbook_name]['env_vars_file']
go_audit_env_vars_file env_vars_file do
  env_vars node[cookbook_name]['env_vars']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

bin = "#{node[cookbook_name]['prefix_bin']}/#{service_name}"
go_audit_binary_systemd service_name do
  cli_opts node[cookbook_name]['cli_opts']
  unit node[cookbook_name]['systemd_unit']
  bin bin
  env_vars_file env_vars_file
  config_file node[cookbook_name]['config_file']
  prefix_log node[cookbook_name]['prefix_log']
  log_file node[cookbook_name]['log_file']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

template '/etc/logrotate.d/go-audit' do
  source 'logrotate/go-audit.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    log_file: node[cookbook_name]['log_file']
  )
end
