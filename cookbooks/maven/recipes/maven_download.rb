

include_recipe 'java'
#Download from Nexus Artifact

maven "#{node[:maven][:app_name]}" do
  group_id "#{node[:maven][:group_id]}"
  artifact_id "#{node[:maven][:app_name]}"
  repositories #{node[:maven][:repositories]}
  packaging 'war'
  version  "#{node[:maven][:app_version]}"
  dest     "/tmp/"
  action :put
end

