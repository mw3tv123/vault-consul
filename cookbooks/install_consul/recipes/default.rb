# Update the host system
apt_update

# Get the 'unzip'package
package 'unzip'

# Fetching Consul
remote_file 'download_consul_binary' do
  source 'https://releases.hashicorp.com/consul/1.2.3/consul_1.2.3_linux_amd64.zip'
  path '/tmp/consul_1.2.3_linux_amd64.zip'
  show_progress true
  checksum 'f97996296ef3905c38c504b35035fb731d3cfd9cad129c9523402a4229c709c5'
  not_if { ::File.exist?('/tmp/consul_1.2.3_linux_amd64.zip') }
end

# Create Consul directory
directory '/opt/consul' do
  # action :create
  not_if { ::Dir.exist?('/opt/consul') }
end

# Extract Consul
execute 'extract_module' do
  command 'unzip -o /tmp/consul_1.2.3_linux_amd64.zip -d /opt/consul/'
  live_stream true
  not_if { ::File.exist?('/opt/consul/consul') }
end

# Create a symlink for Consul
link 'symlink_vault' do
  link_type :symbolic
  target_file '/usr/bin/consul'
  to '/opt/consul'
  not_if { ::File.symlink?('/usr/bin/consul') }
end

# Add service for Consul
template '/etc/systemd/system/consul.service' do
  source 'consul.service.erb'
  not_if { ::File.exist?('/etc/systemd/system/consul.service') }
end

# Start Consul as a service
service 'consul' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
