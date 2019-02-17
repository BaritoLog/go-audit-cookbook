property :name, String, name_property: true
property :cli_opts, Array, default: []
property :systemd_unit, Hash, required: true
property :bin, String, required: true
property :env_vars_file, String
property :config_file, String
property :user, String, required: true
property :group, String, required: true

action :create do
  # Construct command line options
  options = new_resource.cli_opts.join(' ')

  # Configure systemd unit with options
  unit = new_resource.systemd_unit.to_hash

  # Create config file
  template new_resource.config_file do
    source 'go-audit.yaml.erb'
    owner new_resource.user
    group new_resource.group
    mode 0644
  end

  # Build command stack
  cmd_stack = []
  cmd_stack << new_resource.bin
  cmd_stack << options
  unit['Service']['ExecStart'] = cmd_stack.join(' ')
  unit['Service']['EnvironmentFile'] = new_resource.env_vars_file

  # Create service
  systemd_unit "#{new_resource.name}.service" do
    enabled true
    active true
    masked false
    static false
    content unit
    triggers_reload true
    action %i[create enable start]
  end
end

action :restart do
  systemd_unit "#{new_resource.name}.service" do
    action :restart
  end
end
