
#package %w(nagios-nrpe nagios-plugins-ping nagios-plugins-ssh nagios-plugins-http nagios-plugins-swap nagios-plugins-users nagios-plugins-procs nagios-plugins-load nagios-plugins-disk nagios-plugins-all)

=begin
# This will install yum repos
execute 'yum repos' do
  command 'sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
end

package 'nagios-nrpe'
package 'nagios-plugins-ping'
package 'nagios-plugins-ssh'
package 'nagios-plugins-http'
package 'nagios-plugins-swap'
package 'nagios-plugins-users'
package 'nagios-plugins-procs'
package 'nagios-plugins-load'
package 'nagios-plugins-disk'
package 'nagios-plugins-all'
=end

bash 'Install Nagios' do
  code <<-EOH
 yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm   
 yum install -y nrpe nagios-plugins-ping nagios-plugins-ssh nagios-plugins-http nagios-plugins-swap nagios-plugins-users nagios-plugins-procs nagios-plugins-load nagios-plugins-disk nagios-plugins-all 
EOH
end

=begin
cookbook_file '/etc/nagios/nrpe.cfg' do
 source 'nrpe.cfg'
  owner 'root'
  group 'root'
  mode '644'
end
=end

template '/etc/nagios/nrpe.cfg' do
  source 'nrpe.cfg.erb'
  variables({ :monitoraddress => node[:monitoraddress] })
  owner 'root'
  group 'root'
  mode '644'
end

bash 'Restart Nagios' do
  code <<-EOH
sudo systemctl restart nrpe
sudo systemctl enable nrpe
EOH
end
