require 'serverspec'

if os[:family] == 'redhat'
  describe service('ntpd') do
   it { should be_enabled }
   it { should be_running }
  end

elsif ['debian', 'ubuntu'].include?(os[:family])
  describe service('ntp') do
   it { should be_enabled }
   it { should be_running }
  end
end