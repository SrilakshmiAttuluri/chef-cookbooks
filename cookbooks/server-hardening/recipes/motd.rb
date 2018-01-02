
cookbook_file '/etc/motd' do
 source 'motd'
  owner 'root'
  group 'root'
  mode '644'
end

