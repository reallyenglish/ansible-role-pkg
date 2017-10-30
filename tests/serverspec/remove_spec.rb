require "spec_helper"
require "serverspec"

key_dir = "/usr/local/etc/pkg/keys"

describe file("#{key_dir}/none.pub") do
  it { should_not exist }
end
