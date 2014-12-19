require 'serverspec'

include Serverspec::Helper::Exec

describe package('curl') do
  it { should be_installed }
end