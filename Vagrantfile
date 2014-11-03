# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'json'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

def load_user_lib( filename )
  JSON.parse( IO.read(filename) )
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise32"
  config.vm.network "private_network", ip: "192.168.50.4"

  config.omnibus.chef_version = :latest

  # shared folders
  if File.exists? "shared_folders.json"
    JSON.parse(IO.read("shared_folders.json")).each do |folder|
      config.vm.synced_folder folder[0], folder[1], type: "nfs"
    end
  end

  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "mizra"

    chef.json = {
      "postgresql" => {
        "password" => { "postgres" => "postgres" }
      },
    }
  end
end
