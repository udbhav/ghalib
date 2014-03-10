# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'json'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

def load_user_lib( filename )
  JSON.parse( IO.read(filename) )
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.network :forwarded_port, host: 8001, guest: 80
  config.vm.network :forwarded_port, host: 3001, guest: 3000

  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true

  # shared folders
  if File.exists? "shared_folders.json"
    JSON.parse(IO.read("shared_folders.json")).each do |folder|
      config.vm.synced_folder folder[0], folder[1]
    end
  end

  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "ghalib"

    chef.json = {
      "postgresql" => {
        "password" => { "postgres" => "postgres" }
      },
    }
  end
end
