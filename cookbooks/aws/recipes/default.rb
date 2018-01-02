# This cookbook is no longer needed to load the aws-sdk and can be removed
# from node run_lists without any impact

Chef::Log.warn('The default aws recipe does nothing. See the readme for information on using the aws resources')

#AWS_Credentials = data_bag_item('AWS_Credentials', 'main')
sample = data_bag_item('Attributes', 'sample')
=begin
# This is where you will store a copy of your key on the chef-client
secret = Chef::EncryptedDataBagItem.load_secret("/home/ec2-user/chef-repo/.chef/encrypted_data_bag_secret")

# This decrypts the data bag contents of "AWS_Secretcreadentials-->main" and uses the key defined at variable "secret"
AWS_Secretcredentials = Chef::EncryptedDataBagItem.load("AWS_Secretcredentials", "main", secret)
=end

Parameters1 = data_bag_item('Parameters', '1')
Parameters2 = data_bag_item('Parameters', '2')
Parameters3 = data_bag_item('Parameters', '3')
Parameters4 = data_bag_item('Parameters', '4')
Parameters5 = data_bag_item('Parameters', '5')
Parameters6 = data_bag_item('Parameters', '6')

ruby_block "FindAMI" do
        block do
        Chef::Resource::RubyBlock.send(:include,Chef::Mixin::ShellOut)
        command = "(aws ec2 describe-images --filter Name=name,Values=#{sample['app_name']}-#{node[:version]} --query 'Images[*].{ID:ImageId}' --output=text)"
        command_out = shell_out(command)
        Chef::Log.info "Output of FindAMI: #{command_out.stdout}"
        node.default[:aws][:amiid] = "#{command_out.stdout.strip}"
        end
end

#delete stack
aws_cloudformation_stack "#{sample['env_name']}-#{sample['app_name']}-immutable" do
  action :delete
  region 'us-east-1'
end

#Create stack
aws_cloudformation_stack "#{sample['env_name']}-#{sample['app_name']}-immutable" do
  region 'us-east-1'  
  template_source 'customerapp.json'
  parameters ([
    {
      :parameter_key => Parameters1['ParameterKey'],
      :parameter_value => Parameters1['ParameterValue']
    },
    {
      :parameter_key => Parameters2['ParameterKey'],
      :parameter_value => Parameters2['ParameterValue']
    },
    {
       :parameter_key => BaseImageId,
       :parameter_value => "#{node.default[:aws][:amiid]}"
    },
    {
      :parameter_key => Parameters4['ParameterKey'],
      :parameter_value => Parameters4['ParameterValue']
    },
    {
      :parameter_key => Parameters5['ParameterKey'],
      :parameter_value => Parameters5['ParameterValue']
    },
    {
      :parameter_key => Parameters6['ParameterKey'],
      :parameter_value => Parameters6['ParameterValue']
    }
  ])
end

=begin
#Route53
route53_record "create a record" do
  name  "A"
  value ""
  type  "A"
  weight "1"
#  set_identifier "my-instance-id"
  zone_id "Z3LTYX1U4J8VM2"
  overwrite true
  fail_on_error false
  action :create
end
=end
