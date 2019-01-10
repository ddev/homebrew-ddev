class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.5.1.tar.gz"
  sha256 "6df1e15bb44774665bee028ac5c9d11a8babb9646707afd71177566af68581fb"

  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run
  depends_on "docker" => :build
  depends_on "go" => :build

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


