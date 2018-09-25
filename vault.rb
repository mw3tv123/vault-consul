# Update the host system
apt_update

# Get the 'unzip'package
package 'unzip'

# Fetching Vault
remote_file 'vault_0.11.1_linux_amd64.zip' do
  source 'https://releases.hashicorp.com/vault/0.11.1/vault_0.11.1_linux_amd64.zip'
  show_progress true
  checksum 'eb8d2461d0ca249c1f91005f878795998bdeafccfde0b9bae82343541ce65996'
end

directory '{node['etc']['passwd']}/vault' do
  # action :create
end

# Extract Vault
bash 'extract_module' do
  code <<-EOH
    echo "Unziping Vault ... "
    unzip -fo vault_0.11.1_linux_amd64.zip -d vault/
    EOH
  not_if { ::File.exist?('~/vault/vault') }
end
