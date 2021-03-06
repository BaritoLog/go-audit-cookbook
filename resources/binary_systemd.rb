property :name, String, name_property: true
property :cli_opts, Array, default: []
property :unit, Hash, required: true
property :bin, String, required: true
property :env_vars_file, String
property :config_file, String
property :prefix_log, String
property :log_file, String
property :user, String, required: true
property :group, String, required: true

action :create do
  # Construct command line options
  options = new_resource.cli_opts.join(' ')

  # Configure systemd unit with options
  unit = new_resource.unit.to_hash

  # Create log directory
  directory new_resource.prefix_log do
    path new_resource.prefix_log
    mode 0755
    recursive true
    action :create
  end

  # Create config file
  template new_resource.config_file do
    source 'go-audit.yaml.erb'
    owner new_resource.user
    group new_resource.group
    mode 0644
    variables(
      log_file: new_resource.log_file
    )
    notifies :restart, "go_audit_binary_systemd[#{new_resource.name}]", :delayed
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
