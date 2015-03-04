require 'serverspec'

if os[:family] == 'redhat'
  describe service('rpcbind') do
    it { should be_enabled }
    it { should be_running }
  end

elsif %w(debian ubuntu).include?(os[:family])
  if os[:release] == '12.04'
    describe service('portmap') do
      it { should be_enabled }
      it { should be_running }
    end
  else
    describe service('rpcbind') do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
