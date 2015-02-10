#
# Cookbook Name:: cens-base
# Recipe:: default
#
# Author: Steve Nolen <technolengy@gmail.com>
#
# Copyright (c) 2014.
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

node.set['system']['packages']['uninstall'] = ['nano']
node.set['system']["timezone"] = "US/Pacific"

#sshd default config
node.set[:openssh][:server]['HostKey'] = [ "/etc/ssh/ssh_host_rsa_key", "/etc/ssh/ssh_host_dsa_key", "/etc/ssh/ssh_host_ecdsa_key"]
node.set[:openssh][:server]['UsePrivilegeSeparation'] = "yes"
node.set[:openssh][:server]['SyslogFacility'] = "AUTH"
node.set[:openssh][:server]['LogLevel'] = "INFO"
node.set[:openssh][:server]['PermitRootLogin'] = "without-password"
node.set[:openssh][:server]['PermitEmptyPasswords'] = "no"
node.set[:openssh][:server]['PasswordAuthentication'] = "yes"
node.set[:openssh][:server]['AcceptEnv'] = "LANG LC_*"
node.set[:openssh][:server]['Subsystem'] = "sftp /usr/lib/openssh/sftp-server"
node.set[:openssh][:server]['AllowGroups'] = "oadmin localadmin ci-bot root"

#ntp server config - use local ucla time server when possible
node.set['ntp']['servers'] = [
  'tick.ucla.edu',
  '0.pool.ntp.org',
  '1.pool.ntp.org',
  '2.pool.ntp.org',
  '3.pool.ntp.org'
]

#postfix config should turn off TLS since we don't use it currently
node.set['postfix']['main']['smtpd_use_tls'] = "no"
node.set['postfix']['main']['smtp_use_tls'] = "no"

#set chef-client not to verify api cert for now
node.set[:chef_client][:config]["verify_api_cert"] = false

include_recipe "apt"
include_recipe "system::timezone"
include_recipe "system::uninstall_packages"
include_recipe "vim"
include_recipe "emacs"
include_recipe "ntp"
include_recipe "openssh"
include_recipe "curl"
include_recipe "postfix"
include_recipe "nfs::client4"
#include these at the end, so we don't run chef-client init unless the rest of the recipes were successful!
include_recipe "chef-client::config"
include_recipe "chef-client::init_service"
