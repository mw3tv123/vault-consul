# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.hostname = "vault"

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://10.10.10.10:8080"
    config.proxy.no_proxy = "localhost,127.0.0.1,.tma.com.vn,192.168."
  end

	if Vagrant.has_plugin?("vagrant-vbguest")
	    config.vbguest.auto_update = false
	end

  config.vm.network "public_network",
    # bridge: "enp0s3",
    ip: "192.168.101.100"

  config.vm.synced_folder "./data", "/shared"

  config.vm.provider "virtualbox" do |vb|
     vb.gui = true
     vb.memory = "512"
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Updating host ..."
    sudo apt-get update && sudo apt-get upgrade -y

    echo "Installing curl and unzip ..."
    sudo apt-get install -y curl unzip

    echo "Installing Vault ..."
    curl -O https://releases.hashicorp.com/vault/0.11.1/vault_0.11.1_linux_amd64.zip
    unzip vault_0.11.1_linux_amd64.zip -d vault

    echo "Adding Vault to PATH ..."
    echo "export PATH=\"$PATH:$HOME/vault\"" >> ~/.bashrc
    source ~/.bashrc

    echo "Testing Vault ..."
    vault -h
  SHELL

  config.vm.provision "file",
    source: "./config.hcl",
    destination: "~/vault/config.hcl"
end
