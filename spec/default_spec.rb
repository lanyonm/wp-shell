require 'spec_helper'

describe 'wp-shell::default' do

  platforms = {
    'ubuntu' => {
      'package'  => 'apache2',
      'versions' => ['10.04', '12.04']
    },
    'debian' => {
      'package'  => 'apache2',
      'versions' => ['6.0.5']
    },
    'centos' => {
      'package'  => 'httpd',
      'versions' => ['5.8', '6.0', '6.2', '6.3']
    },
    'redhat' => {
      'package'  => 'httpd',
      'versions' => ['5.8', '6.3']
    }
  }

  platforms.each do |platform, value|
    package = value['package']
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        before do
          Fauxhai.mock(platform: platform, version: version)
        end

        let(:chef_run) { ChefSpec::ChefRunner.new.converge 'wp-shell::default' }

        it "installs the Apache package" do
          chef_run.should install_package 'apache2'
        end
        it 'runs apache' do
          expect(chef_run).to start_service 'apache2'
        end
        it 'creates the wp-config file' do
          file = File.join('/opt/wp-shell', 'wp-config.php')
          chef_run.should create_file file
        end
        it 'creates the database' do
          pending "check that the db was created"
        end
      end
    end
  end
end
