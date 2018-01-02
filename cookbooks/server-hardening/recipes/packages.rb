
#package %w(git tar gzip wget libselinux-python libsemanage-python firewalld python-pip syslog)

package 'git'
package 'tar'
package 'gzip'
package 'wget'
package 'libselinux-python'
package 'libsemanage-python'
package 'firewalld'

execute 'pip module' do
   command 'sudo yum -y update && sudo yum -y install python-pip'
end

package 'syslog'

include_recipe 'java'

execute 'setenforce' do
  command 'sudo setenforce Permissive'
end

execute 'pip module' do
  command 'sudo pip install boto'
end

execute 'pip module' do
  command 'sudo pip install boto'
end

=begin
package "java-1.7.0-openjdk" do
  action :remove
end

cookbook_file '/etc/selinux/config' do
 source 'config'
  owner 'root'
  group 'root' 
  mode '644'
end

service 'firewalld' do
  action :start
end
=end

