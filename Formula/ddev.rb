class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  url "https://github.com/rfay/ddev/releases/download/v0.5/ddev-darwin.tar.gz"
  sha256 "69ef77ef7b2f34ebcdc2207d71308742ab0b521d020eaf81d6d19e7645d2a252"

  # Dependencies don't currently seem to be useful since brew doesn't have edge and people likely will not have
  # used brew to install docker.
  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run

  depends_on "go" => :build

  def install
  	system "mkdir", "-p", "#{bin}"
  	system "cp", "darwin/ddev", "#{bin}/ddev"
  end


  test do
    system "#{bin}/ddev", "version"
  end
end


