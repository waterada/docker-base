# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
proj_synced_folder = {}
proj_forwarded_port = {}
projects = YAML.load_file(File.join(File.dirname(__FILE__), 'projects.yml'))
projects.each{|proj|
  proj_synced_folder.merge!(proj['synced_folder'])
  proj_forwarded_port.merge!(proj['forwarded_port']) if proj.has_key?('forwarded_port')
}

# noinspection RubyResolve
Vagrant.configure(2) do |config|
  config.vm.box = 'centos/7'
  config.vm.network 'private_network', ip: '192.168.33.20'
  config.vm.synced_folder '.', '/vagrant', type: 'virtualbox'

  proj_synced_folder.each{|guest, host|
    config.vm.synced_folder host, guest, type: 'virtualbox'
  }
  proj_forwarded_port.each{|guest, host|
    config.vm.network 'forwarded_port', guest: guest, host: host, host_ip: '127.0.0.1'
  }

  config.vm.provision 'shell', inline: <<-SHELL
    /vagrant/provision.sh
  SHELL
end
