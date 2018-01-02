#
# Cookbook:: server-hardening
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'server-hardening::yum-repos'
include_recipe 'server-hardening::packages'
include_recipe 'server-hardening::motd'
include_recipe 'server-hardening::ntp'
include_recipe 'server-hardening::httpd'
include_recipe 'ssh'
include_recipe 'server-hardening::nagios-client'
