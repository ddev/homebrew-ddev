class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  url "https://github.com/drud/ddev/releases/download/v0.9/ddev_osx.v0.9.tar.gz"
  sha256 "7db90286b97c1ac12a548fa656738b23e9172f1cc44fb5ba23d8ed4b2fd8a00c"

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


