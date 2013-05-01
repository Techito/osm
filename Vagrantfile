# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Based on the Ubuntu Precise base-box
  config.vm.box = "ubuntu-precise"
  config.vm.box_url = "http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-vagrant-i386-disk1.box"

  # Set a hostname.
  config.vm.host_name = "vm-osm"

  # Add a host-only network adapter, for samba etc.
  config.vm.network :hostonly, "192.168.33.10"

  # Ensure the project directory is shared with the guest.
  config.vm.share_folder "osm_project", "/mnt/osm_project", "./project"


  # Configure puppet.
  box_path = File.expand_path(__FILE__ + '/..')
  puppet_path = box_path + '/puppet';
  config.vm.provision :puppet do |puppet|
    puppet.manifest_file  = "base.pp"
    puppet.manifests_path = puppet_path + "/manifests"
    puppet.module_path    = [ puppet_path + "/modules" ]
  end

end
