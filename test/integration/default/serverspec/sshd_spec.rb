require 'serverspec'

if os[:family] == 'redhat'
  describe service('sshd') do
    it { should be_enabled }
    it { should be_running }
  end

elsif %w(debian ubuntu).include?(os[:family])
  describe service('ssh') do
    it { should be_enabled }
    it { should be_running }
  end
end
