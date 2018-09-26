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
  not_if { ::File.exist?('/tmp/vault_0.11.1_linux_amd64.zip') }
end

directory '/opt/vault' do
  # action :create
  not_if { ::Dir.exist?('/opt/vault') }
end

# Extract Vault
script 'extract_module' do
  interprefer "bash"
  code <<-EOH
    cd ~/vault_consul && cp config.hcl /opt/vault/config.hcl
    unzip -o /tmp/vault_0.11.1_linux_amd64.zip -d /opt/vault/
    EOH
  not_if { ::File.exist?('/opt/vault/vault') }
end

link 'symlink_vault' do
  link_type :symbolic
  target_file '/usr/bin/vault'
  to '/opt/vault'
  not_if { ::File.symlink?('/usr/bin/vault') }
end

template '/etc/systemd/system/vault.service' do
  source 'vault.service.erb'
  not_if { ::File.exist?('/etc/systemd/system/vault.service') }
end

service 'vault' do
  action [:enable, :start]
end
