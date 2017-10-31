#
# Cookbook Name:: apache
# Recipe:: server
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

# notifies :action, 'resource[name]', :timer
#
# :before, :delayed, :immeditately


if node['platform'] == 'ubuntu'
  include_recipe 'apt'
  package 'apache2' do
    action :install
  end
  template '/var/www/html/index.html' do
    action :create
    source 'index.html.erb'
    notifies :restart, 'service[apache2]', :immediately
    mode '0644'
    owner 'www-data'
    group 'www-data'
  end
  service 'apache2' do
    action [:enable, :start]
    subscribes :restart, 'template[/var/www/html/index.html]', :immediately
  end
end

if node['platform'] == "rhel"
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
end
