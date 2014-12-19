require 'serverspec'

include Serverspec::Helper::Exec

describe package('nano') do
  it { should_not be_installed }
end