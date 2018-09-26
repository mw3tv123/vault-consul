#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

if [[ -z $(which curl) || -z $(which git) || -z $(which vim) ]]; then
  echo "Installing curl, git, vim ... "
  sudo apt-get install -y curl git vim
fi

if [[ -z $(which chef-client) ]]; then
  echo "Installing ChefDK ... "
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 3.2.30
fi

[ $? -eq 0 ] && \
  echo "DONE. Installing Vault ... " || \
  { echo "FAILED. Unable to install Vault. Exit now. "; exit 0; }

sudo chef-client --local-mode vault.rb

echo "Add vault to PATH ..."
echo "export PATH=\"$PATH:/usr/bin/vault\"" >> ~/.profile && source ~/.profile

[ $? -eq 0 ] && \
  echo "DONE. Vault has been sucessfully installed! Exit now." || \
  echo "FAILED to install Vault. Exit now."
