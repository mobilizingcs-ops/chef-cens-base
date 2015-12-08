#
# Cookbook Name:: cens-base
# Recipe:: ldap
#
# Author: Steve Nolen <technolengy@gmail.com>
#
# Copyright (c) 2015.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Configures host as ldap client.
case node['platform_family'] # doesn't support freebsd
when 'debian'
  package 'libnss-ldapd'
  package 'libpam-ldapd'

  service 'nslcd' do
    action [:enable, :start]
  end

  service 'nscd' do
    action [:enable, :start]
  end

  template '/etc/nslcd.conf' do
    source 'nslcd.conf.erb'
    mode '0755'
    action :create
    notifies :restart, 'service[nslcd]', :delayed
    notifies :restart, 'service[nscd]', :delayed
    notifies :run, 'execute[invalidate nscd cache]', :delayed
    variables(
      host: '131.179.144.74',
      base_dn: 'dc=ohmage,dc=org'
    )
  end
  
  template '/etc/nsswitch.conf' do
    source 'nsswitch.conf.erb'
    mode '0755'
    action :create
    notifies :restart, 'service[nslcd]', :delayed
    notifies :restart, 'service[nscd]', :delayed
    notifies :run, 'execute[invalidate nscd cache]', :delayed
  end

else
  fail "`#{node['platform_family']}' is not supported!"
end

execute 'invalidate nscd cache' do
  command 'nscd --invalidate=passwd --invadidate=hosts --invalidate=group --invalidate=services'
  action :nothing
end
