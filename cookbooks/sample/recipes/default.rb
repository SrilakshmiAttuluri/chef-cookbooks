#
# Cookbook:: sample
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# installs Amazon's awscli tools
=begin
AWS_Credentials = data_bag_item('AWS_Credentials', 'main')
node.default[:awscli][:config_profiles][:default][:region] = 'us-east-1'
node.default[:awscli][:config_profiles][:default][:aws_access_key_id] = "AWS_Credentials['aws_access_key_id']"
node.default[:awscli][:config_profiles][:default][:aws_secret_access_key] = "AWS_Credentials['aws_secret_access_key']"
=end

# This is where you will store a copy of your key on the chef-client
secret = Chef::EncryptedDataBagItem.load_secret("/home/ec2-user/encrypted_data_bag_secret")
 
# This decrypts the data bag contents of "AWS_Secretcredentials->main" and uses the key defined at variable "secret"
AWS_Secretcredentials = Chef::EncryptedDataBagItem.load("AWS_Secretcredentials", "main", secret)
node.default[:awscli][:config_profiles][:default][:region] = 'us-east-1'
node.default[:awscli][:config_profiles][:default][:aws_access_key_id] = "AWS_Secretcredentials['aws_access_key_id']"
node.default[:awscli][:config_profiles][:default][:aws_secret_access_key] = "AWS_Secretcredentials['aws_secret_access_key']"

case node[:platform]
when 'debian', 'ubuntu'
  file = '/usr/local/bin/aws'
  cmd = 'apt-get install -y python-pip && pip install awscli'
  completion_file = '/etc/bash_completion.d/aws'
when 'redhat', 'centos', 'fedora', 'amazon', 'scientific'
  file = '/usr/bin/aws'
#  cmd = "#{node[:awscli][:cmd]}"
   cmd = "#{node[:awscli][:cmd_new]}"
#  cmd = 'sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && sudo yum -y update && sudo yum -y install python-pip && pip install awscli'
#   cmd = 'sudo yum -y install python-pip && pip install awscli'
#   cmd = 'sudo yum -y install python-pip && pip install awscli'
end
r = execute 'install awscli' do
  command cmd
  not_if { ::File.exist?(file) }
  if node[:awscli][:compile_time]
    action :nothing
  end
end
if node[:awscli][:compile_time]
  r.run_action(:run)
end

if node[:awscli][:config_profiles]
  default_user = node[:awscli][:user]
  config_profiles_by_user = node[:awscli][:config_profiles].inject({}) do |hash, (profile_name, config_profile)|
    config_profile = config_profile.dup
    user = config_profile.delete(:user) || default_user
    config_profiles = hash[user] ||= {}
    config_profiles[profile_name] = config_profile
    hash
  end

  config_profiles_by_user.each do |(user, config_profiles)|
    if user == 'root'
      config_file = "/#{user}/.aws/config"
    else
      config_file = "/home/#{user}/.aws/config"
    end

    r = directory ::File.dirname(config_file) do
      recursive true
      owner user
      group user
      mode 00700
      not_if { ::File.exist?(::File.dirname(config_file)) }
      if node[:awscli][:compile_time]
        action :nothing
      end
      if not node[:awscli][:compile_time]
        action :create
      end
 end
    if node[:awscli][:compile_time]
      r.run_action(:create)
    end

    r = template config_file do
      mode 00600
      owner user
      group user
      source 'config.erb'
#      source 'configbck.erb'
      variables(
        config_profiles: config_profiles,
      )
      if node[:awscli][:compile_time]
        action :nothing
      end
      if not node[:awscli][:compile_time]
        action :create
      end
    end
    if node[:awscli][:compile_time]
      r.run_action(:create)
    end
  end
end

unless completion_file.nil?
  file completion_file do
    action :create_if_missing
    mode 00644
    owner 'root'
    group 'root'
    # newline is important
    content 'complete -C aws_completer aws'
  end
end

