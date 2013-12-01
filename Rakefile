desc 'Install cookbooks'
task 'cookbooks-install' do
  system 'berks install -b Berksfile -p vendor/berkshelf/'
  system 'rsync -aW --delete vendor/berkshelf/* vendor/cookbooks/'
end

desc 'Bring up vagrant virtual machine'
task 'up' => 'cookbooks-install' do
  system 'vagrant up '
end

desc 'Bring up vagrant virtual machine using vmware_fusion provider'
task 'vmware-up' => 'cookbooks-install' do
  system 'vagrant up --provider=vmware_fusion'
end

desc 'Provision vagrant virtual machine'
task 'provision' => 'cookbooks-install' do
  system 'vagrant provision'
end