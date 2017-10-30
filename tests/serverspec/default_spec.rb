require "spec_helper"
require "serverspec"

package = "pkg"
config  = "/usr/local/etc/pkg.conf"
key_dir = "/usr/local/etc/pkg/keys"
default_user = "root"
default_group = "wheel"

describe package(package) do
  it { should be_installed }
end

describe file(config) do
  it { should be_file }
  its(:content_as_yaml) { should include("SYSLOG" => true) }
  its(:content_as_yaml) { should include("FETCH_TIMEOUT" => 300) }
  its(:content_as_yaml) { should include("FETCH_RETRY" => 5) }
  its(:content_as_yaml) { should include("REPOS_DIR" => ["/etc/pkg/", "/usr/local/etc/pkg/repos/"]) }
end

describe file("/usr/local/etc/pkg/repos/FreeBSD.conf") do
  it { should be_file }
  its(:content_as_yaml) do
    should include(
      "FreeBSD" => include(
        "url" => "pkg+http://pkg.FreeBSD.org/${ABI}/latest",
        "mirror_type" => "srv",
        "signature_type" => "fingerprints",
        "fingerprints" => "/usr/share/keys/pkg",
        "enabled" => false
      )
    )
  end
end

describe file("/usr/local/etc/pkg/repos/isc.conf") do
  it { should be_file }
  its(:content_as_yaml) do
    should include(
      "isc" => include(
        "url" => "http://pkg0.isc.freebsd.org/${ABI}/latest",
        "mirror_type" => "http",
        "signature_type" => "none",
        "fingerprints" => "NONE",
        "enabled" => true
      )
    )
  end
end

describe file(key_dir) do
  it { should exist }
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
end

%w(my your).each do |f|
  describe file("#{key_dir}/#{f}.pub") do
    it { should exist }
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
    its(:content) { should match(/^-----BEGIN PUBLIC KEY-----$/) }
    its(:content) { should match(/^#{Regexp.escape("MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwoMg0XK2SdEaz8b8O6rY")}$/) }
  end
end
