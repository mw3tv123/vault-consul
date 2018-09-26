# Update the host system
apt_update

# Get the 'unzip'package
package 'unzip'

# Fetching Vault
remote_file 'download_vault_binary' do
  source 'https://releases.hashicorp.com/vault/0.11.1/vault_0.11.1_linux_amd64.zip'
  path '/tmp/vault_0.11.1_linux_amd64.zip'
  show_progress true
  checksum 'eb8d2461d0ca249c1f91005f878795998bdeafccfde0b9bae82343541ce65996'
end

directory '/opt/vault' do
  # action :create
end

# Extract Vault
execute 'extract_module' do
  command 'unzip -o vault_0.11.1_linux_amd64.zip -d /opt/vault/'
  live_stream true
  not_if { ::File.exist?('/opt/vault/vault') }
end

link 'symlink_vault' do
  link_type :symbolic
  target_file '/usr/bin/vault'
  to '/opt/vault'
end
