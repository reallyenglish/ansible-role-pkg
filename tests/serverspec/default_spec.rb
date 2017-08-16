require "spec_helper"
require "serverspec"

package = "pkg"
config  = "/usr/local/etc/pkg.conf"

describe package(package) do
  it { should be_installed }
end

describe file(config) do
  it { should be_file }
  its(:content) { should match Regexp.escape("syslog: true") }
end

describe file("/usr/local/etc/pkg/repos/FreeBSD.conf") do
  it { should be_file }
  its(:content) { should match(/FreeBSD: {/) }
  its(:content) { should match(/enabled: no/) }
end

describe file("/usr/local/etc/pkg/repos/Reallyenglish.conf") do
  it { should be_file }
  its(:content) { should match(/Reallyenglish: {/) }
  its(:content) { should match Regexp.escape('url: "http://10.3.build.reallyenglish.com/${ABI}",') }
  its(:content) { should match(/mirror_type: "http",/) }
  its(:content) { should match(/signature_type: "none",/) }
  its(:content) { should match(/fingerprints: "",/) }
  its(:content) { should match(/enabled: yes/) }
end
