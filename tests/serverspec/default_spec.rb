require "spec_helper"
require "serverspec"

package = "pkg"
config  = "/usr/local/etc/pkg.conf"

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

describe file("/usr/local/etc/pkg/repos/Reallyenglish.conf") do
  it { should be_file }
  its(:content_as_yaml) do
    should include(
      "Reallyenglish" => include(
        "url" => "http://10.3.build.reallyenglish.com/${ABI}",
        "mirror_type" => "http",
        "signature_type" => "none",
        "fingerprints" => "NONE",
        "enabled" => true
      )
    )
  end
end
