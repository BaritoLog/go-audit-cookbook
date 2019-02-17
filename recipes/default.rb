#
# Cookbook:: go-audit
# Recipe:: default
#
# Copyright:: 2019, BaritoLog.
#
#

service_name = node[cookbook_name]['service_name']

barito_flow_service_account node[cookbook_name]['user'] do
  group node[cookbook_name]['group']
end

barito_flow_binary_install service_name do
  version node[cookbook_name]['version']
  prefix_root node[cookbook_name]['prefix_root']
  prefix_bin node[cookbook_name]['prefix_bin']
  prefix_temp node[cookbook_name]['prefix_temp']
  mirror node[cookbook_name]['mirror']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

env_vars_file = node[cookbook_name]['env_vars_file']
barito_flow_env_vars_file env_vars_file do
  env_vars node[cookbook_name]['env_vars']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end
