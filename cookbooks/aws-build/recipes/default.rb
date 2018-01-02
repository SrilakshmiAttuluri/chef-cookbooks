#
# Cookbook:: aws-build
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'sample::default'

#Launch Ec2 Instance
execute 'launchEc2' do
  cwd '/home/ec2-user'
  environment 'PATH' => "/usr/bin:#{ENV['PATH']}"
#  environment 'PATH' => "/home/ec2-user/.local/bin:#{ENV['PATH']}"
#  command "aws ec2 run-instances --image-id #{node[:awsBuild][:ami_id]} --count 1 --region us-east-1 --instance-type #{node[:awsBuild][:instance_type]} --key-name chef-workstation --security-group-ids #{node[:awsBuild][:sg_group_id]} --subnet-id #{node[:awsBuild][:vpc_subnet_id]} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Srilu-Testing1}]'"
command "aws ec2 run-instances --image-id #{node[:awsBuild][:ami_id]} --count 1 --region us-east-1 --instance-type #{node[:awsBuild][:instance_type]} --key-name chef-workstation --security-group-ids #{node[:awsBuild][:sg_group_id]} --subnet-id #{node[:awsBuild][:vpc_subnet_id]} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=#{node[:awsBuild][:env_name]}-#{node[:awsBuild][:app_name]}}]'"
end


bash "beforeIP" do
  code lazy{ "echo #{node[:awsBuild][:ip_address]}" }
end

ruby_block "getPublicIP" do
        block do
        Chef::Resource::RubyBlock.send(:include,Chef::Mixin::ShellOut)
#        command = "$(aws ec2 describe-instances --filter Name=tag:Name,Values=Srilu-Testing1 | grep PublicIpAddress | awk -F \":\" '{print $2}' | sed 's/[\",]//g')"
#        command = "$(aws ec2 describe-instances --filter Name=tag:Name,Values=Srilu-Testing | grep PublicIpAddress | awk -F \":\" '{print $2}' | sed 's/[\",]//g')"
        command = "(aws ec2 describe-instances --filter Name=tag:Name,Values=#{node[:awsBuild][:env_name]}-#{node[:awsBuild][:app_name]} --query \"Reservations[*].Instances[*].PublicIpAddress\" --output=text)"
        command_out = shell_out(command)
#        Chef::Log.debug("sucessfully ran test #{command_out.stdout}")
Chef::Log.info "Output of ruby: #{ command_out.stdout }"
#        node.set[:awsBuild][:ip_address] = command_out.stdout
  node.default[:awsBuild][:ip_address] = "#{ command_out.stdout }"
Chef::Log.info "Node Ipaddress : #{ node.default[:awsBuild][:ip_address] }"
#       node.default[:awsBuild][:ip_address] = '54.87.111.1'
        end
end

bash "afterIP" do
  code lazy{ "echo #{node.default[:awsBuild][:ip_address]}" }
end

#Check is Port open are not(True or False)
ruby_block 'Wait for instances to listen on port 22' do
    block do
@ip_address = "#{node.default[:awsBuild][:ip_address]}"
@port = '22' 
require 'socket'
require 'timeout'
Chef::Log.info "Node Ipaddress : #{ @ip_address }"
def is_port_open?(ip, port)
   if not ( ip.empty? or ip.nil? or ip.include? 'None')
     begin
       Timeout::timeout(400) {
         begin
           s = TCPSocket.new(ip, port)
           s.close
           return true
         rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
           return false
         end
       }
     rescue Timeout::Error
       return false
     end
   else
     return false
   end
end
puts is_port_open?(@ip_address,@port)

end
end
