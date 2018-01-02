

# This will install yum repos

execute 'yum repos' do
  command 'sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
  returns [0,1]
end
