#Clean Webapps Folder


directory "#{node[:tomcat][:home]}/webapps/#{node[:tomcat][:app_name]}" do
  action :delete
  recursive true
end

bash 'delete war from tmp' do
    code <<-EOH
     cd #{node[:tomcat][:home]}/webapps/
     pwd
     sudo rm -rf #{node[:tomcat][:app_name]}.war
     cd
     pwd
    EOH
end

=begin
directory "#{node[:tomcat][:home]}/webapps/#{node[:tomcat][:app_name]}.war" do
 owner 'root'
 group 'root' 
 action :delete
  only_if { File.exist? "#{node[:tomcat][:home]}/webapps/#{node[:tomcat][:app_name]}.war" }
end
=end

