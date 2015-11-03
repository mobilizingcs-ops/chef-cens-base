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

node.set['authorization']['sudo']['sudoers_defaults'] = [
  'env_reset',
  'secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'
]
node.set['authorization']['sudo']['include_sudoers_d'] = true
node.set['authorization']['sudo']['groups'] = ['sudo']

include_recipe 'sudo'

# oadmin group with snolen&hongsudt
sudo 'oadmin' do
  group 'oadmin'
  host 'ALL'
  nopasswd true
end

# standard default user
sudo 'localadmin' do
  user 'localadmin'
  host 'ALL'
  nopasswd true
end

# ci-bot can run some commands as root
# this logic is crappy and should likely be handled somewhere else.
case node['fqdn']
when 'ocpu.ohmage.org' # ocpu host
  ci_commands = ['/usr/sbin/service opencpu restart', '/usr/bin/R CMD INSTALL plotbuilder --library=/usr/local/lib/R/site-library']
when 'rstudio.mobilizingcs.org' # rstudio host
  ci_commands = ['/usr/bin/R CMD INSTALL MobilizR --library=/usr/local/lib/R/site-library']
when 'pilots.mobilizelabs.org', 'sandbox.mobilizingcs.org', 'test.mobilizingcs.org', 'lausd.mobilizingcs.org' # ohmage hosts
  ci_commands = ['/bin/cp -ur /home/ci-bot/* /var/www/*', '/bin/cp -r /home/ci-bot/* /var/lib/tomcat7/webapps/*', '/bin/cp -r /home/ci-bot/* /opt/flyway/sql/*', '/opt/flyway/flyway *', '/usr/sbin/service tomcat7 *', '/bin/sed -i /var/www/survey/*']
end

ci_hosts = %w(ocpu.ohmage.org rstudio.mobilizingcs.org pilots.mobilizelabs.org test.mobilizingcs.org lausd.mobilizingcs.org)
case node['fqdn']
when *ci_hosts
  sudo 'ci-bot' do
    user 'ci-bot'
    nopasswd true
    commands ci_commands
  end
end
