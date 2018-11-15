class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/releases/download/v1.4.0/ddev_macos.v1.4.0.tar.gz"
  sha256 "37014bc693146eff7fe2aca86db2172db565d3051082c2f51d62ac6dc7980a96"

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


