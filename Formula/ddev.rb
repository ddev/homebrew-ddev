class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  url "https://github.com/drud/ddev/releases/download/v0.6/ddev_osx.v0.6.tar.gz"
  sha256 "93d6f0fbae170c845b2333c541c9a7f734b18225f6570a4a6757cf00930bf742"

  # Dependencies don't currently seem to be useful since brew doesn't have edge and people likely will not have
  # used brew to install docker.
  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run

  def install
  	system "mkdir", "-p", "#{bin}"
  	system "cp", "ddev", "#{bin}/ddev"
  end

  test do
    system "#{bin}/ddev", "version"
  end
end


