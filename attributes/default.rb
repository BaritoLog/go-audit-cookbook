#
# Cookbook:: go-audit
# Attribute:: default
#
# Copyright:: 2019, BaritoLog.
#
#

cookbook_name = 'go-audit'

# User and group of service process
default[cookbook_name]['user'] = 'barito'
default[cookbook_name]['group'] = 'barito'

# Temp directory
default[cookbook_name]['prefix_temp'] = '/var/cache/chef'
# Installation directory
default[cookbook_name]['prefix_root'] = '/opt'
# Where to link binaries
default[cookbook_name]['prefix_bin'] = '/opt/bin'

#
# go-audit
#

# go-audit version
default[cookbook_name]['version'] = '0.1.0'
go_audit_version = node[cookbook_name]['version']

# where to get the binary
default[cookbook_name]['binary'] = 'go-audit-linux'
go_audit_binary = node[cookbook_name]['binary']
default[cookbook_name]['mirror'] =
  "https://github.com/BaritoLog/go-audit/releases/download/#{go_audit_version}/#{go_audit_binary}"
default[cookbook_name]['service_name'] = 'go-audit'
