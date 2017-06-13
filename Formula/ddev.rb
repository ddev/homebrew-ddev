class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  url "https://github.com/drud/ddev/releases/download/v0.7/ddev_osx.v0.7.tar.gz"
  sha256 "494a3a74e0c7dce5cee7ccfe66c9d95d278a0698a188355a525a314b12b866b8"

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


