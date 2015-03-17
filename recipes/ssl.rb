# SSL
chef_gem 'chef-vault'
require 'chef-vault'

# Handle some node specific dealies, clean this up it looks terrible!
no_ssl = %w(dev.opencpu.org dev1.opencpu.org dev2.opencpu.org starbuck.ohmage.org cavil.ohmage.org)

case node['fqdn']
when 'web.ohmage.org'
  %w(ohmage.org mobilizingcs.org).each do |d|
    item = ChefVault::Item.load('ssl', d)
    file "/etc/ssl/certs/#{d}.crt" do
      owner 'root'
      group 'root'
      mode '0777'
      content item['cert']
    end
    file "/etc/ssl/private/#{d}.key" do
      owner 'root'
      group 'root'
      mode '0600'
      content item['key']
    end
  end
when 'pilots.mobilizelabs.org'
  item = ChefVault::Item.load('ssl', 'pilots.mobilizelabs.org')
  file '/etc/ssl/certs/pilots.mobilizelabs.org.crt' do
    owner 'root'
    group 'root'
    mode '0777'
    content item['cert']
  end
  file '/etc/ssl/private/pilots.mobilizelabs.org.key' do
    owner 'root'
    group 'root'
    mode '0600'
    content item['key']
  end
when *no_ssl
  # noop these guys
  Chef::Log.info("I've been told not to configure SSL hosts on this node")
else
  item = ChefVault::Item.load('ssl', node['domain'])
  file "/etc/ssl/certs/#{node['domain']}.crt" do
    owner 'root'
    group 'root'
    mode '0777'
    content item['cert']
  end
  file "/etc/ssl/private/#{node['domain']}.key" do
    owner 'root'
    group 'root'
    mode '0600'
    content item['key']
  end
end
