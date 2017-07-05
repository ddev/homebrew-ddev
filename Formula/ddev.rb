class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  url "https://github.com/drud/ddev/releases/download/v0.8/ddev_osx.v0.8.tar.gz"
  sha256 "e1b1e33b694730ae3ecaac661292cc7238dd5393b77eeb838599f2336a40e811"

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


