#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2010-2016, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Chef::Log.warn('The default tomcat recipe does nothing. See the readme for information on using the tomcat resources')

include_recipe 'java'

#Create User tomcat
user 'tomcat'

#Create group tomcat and add tomcat user to group
group 'tomcat' do
  members 'tomcat'
  action :create
end

#Install tomcat and change ownership of Tomcat Installation
tomcat_install 'helloworld' do
  dir_mode '0755'
  version '7.0.42'
  install_path '/opt/tomcat_helloworld_7_0_42/'
  tomcat_user 'tomcat'
  tomcat_group 'tomcat'
end

#Drop off our own server.xml that uses a non-default port setup
#cookbook_file '/opt/tomcat_helloworld/conf/server.xml' do
cookbook_file "#{node[:tomcat][:home]}/conf/server.xml" do
  source 'server.xml'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'tomcat_service[helloworld]'
end

#Create ROOT directory
directory "#{node[:tomcat][:home]}/webapps/ROOT" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#cookbook_file '/opt/tomcat_helloworld/webapps/ROOT/index.jsp' do
cookbook_file "#{node[:tomcat][:home]}/webapps/ROOT/index.jsp" do
  source 'index.jsp'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  notifies :restart, 'tomcat_service[helloworld]'
end

#cookbook_file '/opt/tomcat_helloworld/conf/tomcat-users.xml' do
cookbook_file "#{node[:tomcat][:home]}/conf/tomcat-users.xml" do
  source 'tomcat-users.xml'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'tomcat_service[helloworld]'
end

file '/etc/init.d/tomcat' do
  mode '0755'
  owner 'root'
  group 'root'
end

cookbook_file "/etc/init.d/tomcat" do
  source 'tomcat-initscript.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  notifies :restart, 'tomcat_service[helloworld]'
end

#Start tomcat
tomcat_service 'helloworld' do
  action :start
  tomcat_user 'tomcat'
  tomcat_group 'tomcat'
  env_vars [{ 'CATALINA_PID' => "#{node[:tomcat][:home]}/bin/tomcat.pid" }]
end
