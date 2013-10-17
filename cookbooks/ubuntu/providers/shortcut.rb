action :install do

  short_cut_dir = "/home/#{new_resource.username}/.local/share/applications"

  directory short_cut_dir do
    owner new_resource.username
    group new_resource.username
    recursive true
    mode 644
    action :create
  end

  file "#{short_cut_dir}/#{new_resource.name}.desktop"do

    content <<-CONTENT
    #!/usr/bin/env xdg-open

    [Desktop Entry]
    Version=1.0
    Type=Application
    Terminal=false
    Icon[en_US]=#{new_resource.icon}
    Name[en_US]=Intellij
    Exec=#{new_resource.application}
    Name=Intellij
    Icon=#{new_resource.icon}
    CONTENT
    mode '644'
    owner new_resource.username
    group new_resource.username
    action :create
  end
end