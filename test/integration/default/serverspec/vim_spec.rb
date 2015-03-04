require 'serverspec'

describe command('which vim') do
  its(:exit_status) { should eq 0 }
end
