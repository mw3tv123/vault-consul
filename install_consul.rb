# Update the host system
apt_update

# Get the 'unzip'package
package 'unzip'

# Fetching Consul
remote_file 'downoad_consul_binary' do
  source 'https://releases.hashicorp.com/consul/1.2.3/consul_1.2.3_linux_amd64.zip'
  path '/tmp/consul_1.2.3_linux_amd64.zip'
  show_progress true
  checksum 'f97996296ef3905c38c504b35035fb731d3cfd9cad129c9523402a4229c709c5'
end

directory '/opt/consul' do
  # action :create
end

# Extract Consul
execute 'extract_module' do
  command 'unzip -o /tmp/consul_1.2.3_linux_amd64.zip -d /opt/consul/'
  live_stream true
  not_if { ::File.exist?('/opt/consul/consul') }
end

link 'symlink_vault' do
  link_type :symbolic
  target_file '/usr/bin/consul'
  to '/opt/consul'
end

template '/etc/systemd/system/consul.service' do
  source 'consul.service.erb'
end

service 'consul' do
  action [:enable, :start]
end
