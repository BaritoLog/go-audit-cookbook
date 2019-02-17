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

#
# go-audit
#

default[cookbook_name]['service_name'] = 'go-audit-producer'
