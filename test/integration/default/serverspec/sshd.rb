require 'serverspec'

include Serverspec::Helper::Exec

describe package('ssh') do
  it { should be_installed }
end

describe service('ssh') do
  it { should be_enabled }
end