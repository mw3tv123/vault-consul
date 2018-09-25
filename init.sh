#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

if [[ -z $(which curl) || -z $(which git) || -z $(which vim) ]]; then
  echo "Installing curl, git, vim ... "
  sudo apt-get install -y curl git vim
fi

[ $? -eq 0 && -z $(which chef-client) ] && \
  echo "DONE. Installing ChefDK ... " || \
  { echo "FAILED. Unable to install needed packages. Exit now. "; exit 0; }

curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 3.2.30

[ $? -eq 0 ] && \
  echo "DONE. Installing Vault ... " || \
  { echo "FAILED. Unable to install Vault. Exit now. "; exit 0; }

cp vault.rb .. && cd ..
sudo chef-client --local-mode vault.rb

[ $? -eq 0 ] && \
  echo "DONE. Vault has been sucessfully installed! Exit now." || \
  echo "FAILED to install Vault. Exit now."
