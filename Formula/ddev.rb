class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  url "https://github.com/drud/ddev/releases/download/v0.13.0/ddev_osx.v0.13.0.tar.gz"
  sha256 "d7bc6b0d6cf99811d2b127f9cbfc7865f2332ed843eeb3a3c733041ccb48326a"

  # Dependencies don't currently seem to be useful since people likely will not have
  # used brew to install docker.
  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run

  def install
    system "mkdir", "-p", "#{bin}"
    system "cp", "ddev", "#{bin}/ddev"
    bash_completion.install "ddev_bash_completion.sh" => "ddev"
  end

  def caveats
  <<~EOS
ddev requires docker and docker-compose.
You can install them with "brew cask install docker"
or from the docker.com website.
  EOS
  end

  test do
    system "#{bin}/ddev", "version"
  end
end


