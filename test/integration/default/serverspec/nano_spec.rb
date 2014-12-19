require 'serverspec'

#include Serverspec::Helper::Exec

describe command('which nano') do
  its(:exit_status) { should eq 1 }
end