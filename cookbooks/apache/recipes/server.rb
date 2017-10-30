#
# Cookbook Name:: webserver
# Recipe:: setup
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

# notifies :action, 'resource[name]', :timer
#
# :before, :delayed, :immeditately

package 'httpd' do
  action :install
end

template '/var/www/html/index.html' do
  action :create
  source 'index.html.erb'
  notifies :restart, 'service[httpd]', :immediately
  mode '0644'
  owner 'apache'
  group 'apache'
end

service 'httpd' do
  action [:enable, :start]
  subscribes :restart, 'template[/var/www/html/index.html]', :immediately
end
