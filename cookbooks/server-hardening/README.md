# server-hardening

TODO: 6 Recipes + 2 cookbook(java and ssh) for serverhardening
1) yum-repos : Install yum repos 
   returns [0,1] : by default 0 is success. To make 1 as success, Placed 0 and 1 in returns of execute to give success for both the outputs 
2) packages : install packages (git, tar, gzip, wget, libselinux-python, libsemanage-python, firewalld, python-pip, syslog)
3) motd : To displat (This system is managed by Chef) as cookbook files
4) ntp : Install additional Package ntp and start the service ntpd
5) httpd : Install package httpd and start the service httpd
6) nagios-client : Install Nagios and Plugins (nagios-plugins-ping nagios-plugins-ssh nagios-plugins-http nagios-plugins-swap nagios-plugins-users nagios-plugins-procs nagios-plugins-load nagios-plugins-disk nagios-plugins-all) and give the IP address of server to monitor using Template resource and restart nrpe(Nagios)

java cookbook to install Specific version and ssh cookbook to make PermitRootLogin and PasswordAuthentication values to "NO"
