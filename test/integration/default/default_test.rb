# # encoding: utf-8

# Inspec test for recipe go-audit::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  describe group('go-audit') do
    it { should exist }
  end

  describe user('go-audit')  do
    it { should exist }
  end
end

describe package('auditd') do
  it { should be_installed }
end

describe directory('/opt') do
  its('mode') { should cmp '0755' }
end

describe directory('/opt/bin') do
  its('mode') { should cmp '0755' }
end

describe directory('/var/cache/chef') do
  its('mode') { should cmp '0755' }
end

describe file('/opt/bin/go-audit') do
  its('mode') { should cmp '0755' }
end

describe file('/etc/default/go-audit') do
  its('mode') { should cmp '0600' }
end

describe systemd_service('go-audit') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/var/log/go-audit/go-audit.log') do
  its('mode') { should cmp '0660' }
end

describe file('/etc/logrotate.d/go-audit') do
  its('mode') { should cmp '0644' }
end
