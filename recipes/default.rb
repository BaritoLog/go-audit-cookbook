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
