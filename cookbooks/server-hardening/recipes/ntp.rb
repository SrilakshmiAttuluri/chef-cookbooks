
package 'ntp' do
 notifies :restart, 'service[ntpd]', :immediately
end

service 'ntpd' do
  action :start
end
