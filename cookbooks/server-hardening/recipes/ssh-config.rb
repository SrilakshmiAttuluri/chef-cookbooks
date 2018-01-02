
service "ssh"

#Disable root login
ssh_config "PermitRootLogin" do
  string "PermitRootLogin #{node[:ssh][:permit_root_login]}"
end

#Disable password authentication
ssh_config "PasswordAuthentication" do
  string "PasswordAuthentication #{node[:ssh][:password_authentication]}"
end
