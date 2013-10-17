tmp = '/tmp'
vmware_tools_mount_dir = "#{tmp}/vmware_tools_mount"
vmware_tools_extract_dir = "#{tmp}/vmware_tools"

[vmware_tools_mount_dir, vmware_tools_extract_dir].each do |directory|
  directory(directory) do
    action :create
  end
end

mount vmware_tools_mount_dir do
  device node[:vmware_tools][:source]
  action :mount
end

execute :extract_vmware_tools do
  command "tar -xzf #{vmware_tools_mount_dir}/VMwareTools*.tar.gz -C #{vmware_tools_extract_dir}"
  action :run
end

execute :install_vmware_tools do
  command "#{vmware_tools_extract_dir}/vmware-tools-distrib/vmware-install.pl -default"
  action :run
end