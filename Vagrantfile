# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
BOX_NAME = "ubuntu/focal64"

cluster = {
  "node1" => { :ip => "192.168.56.10", :cpus => 3, :mem => 3072 },
  "node2" => { :ip => "192.168.56.11", :cpus => 3, :mem => 3072 },
}

Vagrant.configure("2") do |config|

  cluster.each_with_index do |(hostname, info), index|

    config.vm.define hostname do |cfg|

      cfg.vm.provider :virtualbox do |vb, override|
      
        config.vm.box = BOX_NAME
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname
        vb.name = hostname
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]
      
      end # end provider

      config.vm.provision :ansible do |ansible|
        ansible.playbook = "setup-ssh.yaml"
      end

    end # end config

  end # end cluster

end
