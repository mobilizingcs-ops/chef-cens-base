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

include_recipe "system::hostname"
include_recipe "system::timezone"
include_recipe "system::uninstall_packages"
include_recipe "vim"
include_recipe "emacs"
include_recipe "ntp"
include_recipe "sshd"
include_recipe "nfs::client4"
include_recipe "curl"