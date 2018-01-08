class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  url "https://github.com/drud/ddev/releases/download/v0.11.0/ddev_osx.v0.11.0.tar.gz"
  sha256 "7e741f5f2e6f1b387d77090b8ff73847d5a2adad455569a057de2654c2bff4aa"

  # Dependencies don't currently seem to be useful since brew doesn't have edge and people likely will not have
  # used brew to install docker.
  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run

  def install
  	system "mkdir", "-p", "#{bin}"
  	system "cp", "ddev", "#{bin}/ddev"
	bash_completion.install "ddev_bash_completion.sh" => "ddev"
  end

  test do
    system "#{bin}/ddev", "version"
  end
end


