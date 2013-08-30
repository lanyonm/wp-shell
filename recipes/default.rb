#
# Cookbook Name:: wp-shell
# Recipe:: default
#
# Copyright 2013, Michael Lanyon
#

include_recipe 'apt'
include_recipe 'apache2'
include_recipe 'build-essential'
include_recipe 'git'
include_recipe 'rsync'
include_recipe 'vim'
include_recipe 'apache2::mod_deflate'
include_recipe 'apache2::mod_expires'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_rewrite'
include_recipe 'mysql::server'
include_recipe 'php'
include_recipe 'php::module_mysql'

# create the WP vhost
web_app node['wp-shell']['server_name'] do
  server_name node['wp-shell']['server_name']
  # server_aliases ["www.my-site.localhost"]
  docroot node['wp-shell']['docroot']
end

# create the wp-config.php file
template "#{node['wp-shell']['docroot']}/wp-config.php" do
  source "wp-config.php.erb"
  variables(:wp_config => node['wp-shell'].to_hash)
  mode 0644
end

# import the mysql data
execute "create-database" do
  command "mysql -u #{node['wp-shell']['db_user']} -p#{node['wp-shell']['db_password']} -e 'CREATE DATABASE IF NOT EXISTS #{node['wp-shell']['db_name']}' && mysql -u #{node['wp-shell']['db_user']} -p#{node['wp-shell']['db_password']} #{node['wp-shell']['db_name']} < #{node['wp-shell']['host-folder']}/#{node['wp-shell']['db-dump-name']}"
  not_if ("mysqlshow -u #{node['wp-shell']['db_user']} -p#{node['wp-shell']['db_password']} #{node['wp-shell']['db_name']} | grep wp_users")
end
