#
# Cookbook:: tomcat-deploy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'tomcat-deploy::clean'

include_recipe 'maven'

include_recipe 'maven::maven_download'

#Deploy to Tomcat
execute "move file to tomcat" do
  command "mv /tmp/#{node[:tomcat][:app_name]}.war #{node[:tomcat][:home]}/webapps/"
  cwd "#{node[:tomcat][:home]}/webapps"
  notifies :restart, "tomcat_service[helloworld]", :immediately
end
