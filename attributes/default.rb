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

# environment variables
default[cookbook_name]['prefix_env_vars'] = '/etc/default'
default[cookbook_name]['env_vars_file'] = "#{node[cookbook_name]['prefix_env_vars']}/#{node[cookbook_name]['service_name']}"
default[cookbook_name]['env_vars'] = {}

# files locations
default[cookbook_name]['config_file'] = '/etc/go-audit.yaml'
default[cookbook_name]['prefix_log'] = '/var/log/go-audit'
default[cookbook_name]['log_file'] = "#{node[cookbook_name]['prefix_log']}/go-audit.log"

# go-audit daemon options, used to create the ExecStart option in service
default[cookbook_name]['cli_opts'] = ["-config #{node[cookbook_name]['config_file']}"]

# go-audit Systemd service unit, include config
default[cookbook_name]['systemd_unit'] = {
  'Unit' => {
    'Description' => 'go-audit',
    'After' => 'network.target auditd.service',
    'Conflicts' => 'auditd.service'
  },
  'Service' => {
    'Type' => 'simple',
    'ExecStart' => 'TO_BE_COMPLETED'
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  }
}
