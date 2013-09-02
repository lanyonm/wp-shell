wp-shell Cookbook [![Build Status](https://travis-ci.org/LanyonM/wp-shell.png)](https://travis-ci.org/LanyonM/wp-shell)
=================
I don't usually use WordPress, but when I do, I configure it with Chef.

This application cookbook provides a recipe for configuring the shell for a WordPress installation.  By 'shell', I mean the necessary Apache, PHP, and MySQL configuration needed to develop on a WordPress site.  The recipe will also bootstrap the database with a MySQL dump and run phpMyAdmin on port 8888.

The intended use is with Vagrant, so the PHP code can live on the host machine, while the Vagrant-controlled VM will house the web server and database.  See Usage below for more information.

Requirements
------------
For the dependencies of this cookbook, have a look at the [metadata](metadata.rb).  It's more than is absolutely required, but the extras are low overhead.

#### Platform

* Ubuntu

Tested on:

* Ubuntu 12.04

Attributes
----------
#### wp-shell::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Default Value</th>
  </tr>
  <tr>
    <td><tt>['wp-shell']['docroot']</tt></td>
    <td>String</td>
    <td><tt>'/opt/wp-shell'</tt></td>
  </tr>
  <tr>
    <td><tt>['wp-shell']['server_name']</tt></td>
    <td>String</td>
    <td><tt>'wp_database'</tt></td>
  </tr>
  <tr>
    <td><tt>['wp-shell']['db_name']</tt></td>
    <td>String</td>
    <td><tt>'wp_database'</tt></td>
  </tr>
  <tr>
    <td><tt>['wp-shell']['db_user']</tt></td>
    <td>String</td>
    <td><tt>'root'</tt></td>
  </tr>
  <tr>
    <td><tt>['wp-shell']['db_password']</tt></td>
    <td>String</td>
    <td><tt>node['mysql']['server_root_password']</tt></td>
  </tr>
  <tr>
    <td><tt>['wp-shell']['host-folder']</tt></td>
    <td>String</td>
    <td><tt>'/home/vagrant/host'</tt></td>
  </tr>
  <tr>
    <td><tt>['wp-shell']['db-dump-name']</tt></td>
    <td>String</td>
    <td><tt>'dump.sql'</tt></td>
  </tr>
</table>


Usage
-----
#### wp-shell::default
This recipe was designed to be invoked from within Vagrant.  Here's some of the Vagrant config:

    config.vm.synced_folder "<path_on_host_machine_to_database_dump>", "/home/vagrant/host"
    config.vm.synced_folder "<path_on_host_machine_to_wp_src>", "/opt/wordpress"

    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe 'wp-shell::default'

      chef.json = {
        'mysql' => {
          'server_root_password' => 'rootpass'
        },
        'wp-shell' => {
          'server_name' => 'wordpress.dev',
          'docroot' => '/opt/wordpress',
          'db_name' => 'wp_db_name'
        }
      }
    end

A couple things to note:

* The `./cookbooks` directory will need to contain the this cookbook and all it's dependencies.
* You'll need to add a `hosts` file entry on the host machine for the `server_name` you choose.

Testing
-------
This cookbook is tested by Travis-CI, but you may want to test it locally as well.  Before running these tests you'll need to install the dependencies with Berkshelf: `bundle exec berks install --path vendor/cookbooks`.  To do so, use the following commands:

    bundle exec foodcritic ./
    bundle exec knife cookbook test wp-shell -c test/.chef/knife.rb
    bundle exec rspec

TODO
----

* Add test-kitchen and officially support more distros

CHANGELOG
-------------------------
[changelog is here](CHANGELOG.md)

License and Authors
-------------------
Copyright 2013, Michael Lanyon

Apache License, Version 2.0
