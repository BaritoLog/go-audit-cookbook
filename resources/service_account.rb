property :service_user, String, name_property: true
property :service_group, String, required: true

action :create do
  group new_resource.service_group do
    system true
  end

  user new_resource.service_user do
    comment "#{new_resource.service_user} service account"
    group new_resource.service_group
    system true
    shell '/sbin/nologin'
  end
end
