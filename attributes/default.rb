#
# Cookbook Name:: wp-shell
# Attributes:: default
#
# Copyright 2013, Michael Lanyon
#

node.default['wp-shell']['docroot'] = '/opt/wp-shell'
node.default['wp-shell']['server_name'] = 'wordpress.dev'

node.default['wp-shell']['db_name'] = 'wp_database'
node.default['wp-shell']['db_user'] = 'root'
node.default['wp-shell']['db_password'] = node['mysql']['server_root_password']
# node.default['wp-shell']['']

node.default['wp-shell']['host-folder'] = '/home/vagrant/host'
node.default['wp-shell']['db-dump-name'] = 'dump.sql'
