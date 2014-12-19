require 'serverspec'

describe command('which curl') do
  its(:exit_status) { should eq 0 }
end