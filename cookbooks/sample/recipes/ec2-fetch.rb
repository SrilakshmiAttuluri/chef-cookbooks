
sample = data_bag_item('Attributes', 'sample')

#include_recipe 'sample::default'

ruby_block "fetchinstanceid" do
        block do
        Chef::Resource::RubyBlock.send(:include,Chef::Mixin::ShellOut)
        command = "(aws ec2 describe-instances --filter Name=tag:Name,Values=#{sample['app_name']} --query \"Reservations[*].Instances[*].InstanceId\" --output=text)"
        command_out = shell_out(command)
        Chef::Log.info "Output of fethinstanceid: #{command_out.stdout}"
        node.default[:sample][:instanceid] = "#{command_out.stdout.strip}"
        Chef::Log.info "Node InstanceId : #{node.default[:sample][:instanceid]}"
        end
end

ruby_block "amicreation" do
        block do
        Chef::Resource::RubyBlock.send(:include,Chef::Mixin::ShellOut)
        Chef::Log.info "Node InstanceId:#{node.default[:sample][:instanceid]}:#{sample['app_name']}-#{node[:version]}"
        command = "(aws ec2 create-image --instance-id #{node.default[:sample][:instanceid]} --name #{sample['app_name']}-#{node[:version]} --no-reboot)"
        Chef::Log.info "(aws ec2 create-image --instance-id #{node.default[:sample][:instanceid]} --name #{sample['app_name']}-#{node[:version]} --no-reboot)"
        command_out = shell_out(command)
        Chef::Log.info "Output of amicreation: #{ command_out.stdout }"
       end
end

#sleep(4.minutes)
