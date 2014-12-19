require 'serverspec'

include Serverspec::Helper::Exec

describe package('emacs') do
  it { should be_installed }
end