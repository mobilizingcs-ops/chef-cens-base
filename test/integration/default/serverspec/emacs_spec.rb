require 'serverspec'

describe command('which emacs') do
  its(:exit_status) { should eq 0 }
end
