class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.5.1.tar.gz"
  sha256 "6df1e15bb44774665bee028ac5c9d11a8babb9646707afd71177566af68581fb"

  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run
  depends_on "docker" => :build
  depends_on "go" => :build

  bottle do
    root_url "https://dl.bintray.com/drud/bottles-ddev"
    cellar :any_skip_relocation
    sha256 "16316d98bcad17ba0b53f37bab2b134835f6a6d334ec1485e43cf620ae9a8cf5" => :x86_64_linux
    sha256 "d1139d57fb8ea0f3c75563caf81ab091e5ba096008b107f1fa15465a067c51ce" => :el_capitan
  end

  def install
    system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
    system "mkdir", "-p", "#{bin}"
    if OS.mac?
      system "cp", "bin/darwin/darwin_amd64/ddev", "#{bin}/ddev"
      system "bin/darwin/darwin_amd64/ddev_gen_autocomplete"
    else
      system "cp", "bin/linux/ddev", "#{bin}/ddev"
      system "bin/linux/ddev_gen_autocomplete"
    end
    bash_completion.install "bin/ddev_bash_completion.sh" => "ddev"
  end

  test do
    system "#{bin}/ddev", "version"
  end

  def caveats
  <<~EOS
ddev requires docker and docker-compose.
Docker installation instructions at https://ddev.readthedocs.io/en/latest/users/docker_installation/
  EOS
  end

end


