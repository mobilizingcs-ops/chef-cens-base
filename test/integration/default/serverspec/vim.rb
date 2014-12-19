require 'serverspec'

include Serverspec::Helper::Exec

describe package('vim') do
  it { should be_installed }
end