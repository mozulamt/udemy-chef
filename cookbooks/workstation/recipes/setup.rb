#include_recipe 'apt'

package %w(tree ntp git) do
  action :install
end

#service 'ntpd' do
#  action [ :enable, :start]
#end

template '/etc/motd' do
  source 'motd.erb'
  variables({
    :name => 'Niels',
    memory: node['memory']['total']
  })
  action :create
  mode '0644'
  owner 'root'
  group 'root'
end

user 'blurg' do
  comment 'blurg' 
  uid '1001'
  home '/home/blurg'
  shell '/bin/bash'
end

group 'admins' do
  members 'blurg'
end
