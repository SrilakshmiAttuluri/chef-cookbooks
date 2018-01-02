default[:awscli][:compile_time] = false
default[:awscli][:user] = "root"
default[:awscli][:config_profiles][:default][:region] 
default[:awscli][:config_profiles][:default][:aws_access_key_id] 
default[:awscli][:config_profiles][:default][:aws_secret_access_key]
default[:awscli][:config_profiles][:default][:user] = 'root'
default[:awscli][:name] = 'Srilu AMI'
default[:awscli][:cmd_new] = 'sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && sudo yum -y update && sudo yum -y install python-pip && pip install awscli'
default[:awscli][:cmd] = 'sudo yum -y install python-pip && pip install awscli'

default[:sample][:app_name] = 'chef-workstation'
default[:sample][:name] = 'chef-ws'
