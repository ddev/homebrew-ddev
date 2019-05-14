class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.8.0.tar.gz"
  sha256 "6feca0f3e9c39c3753b30866db084b060ffc8815aa4db19a29e3a95b9bf029ab"

  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run
  depends_on "docker" => :build
  depends_on "go" => :build
  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.8.0/"
    cellar :any_skip_relocation
    sha256 "48089221662afab5f5d1c9181a0e6de723d74573d4ff5cf8cf398f90ef52ae7c" => :x86_64_linux
    sha256 "0b1b395146b3f72f0bf6d59a59d4cb78c1f881424ed59a6840777d824e8f1ad3" => :sierra
  end

  def install
    system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
    system "mkdir", "-p", "#{bin}"
    if OS.mac?
      system "cp", ".gotmp/bin/darwin_amd64/ddev", "#{bin}/ddev"
      system ".gotmp/bin/darwin_amd64/ddev_gen_autocomplete"
    else
      system "cp", ".gotmp/bin/ddev", "#{bin}/ddev"
      system ".gotmp/bin/ddev_gen_autocomplete"
    end
    bash_completion.install ".gotmp/bin/ddev_bash_completion.sh" => "ddev"
  end

  test do
    system "#{bin}/ddev", "version"
  end

  def caveats
  <<~EOS
PLEASE MAKE SURE to do `mkcert -install`, which may require your sudo password.

ddev requires docker and docker-compose.
Docker installation instructions at https://ddev.readthedocs.io/en/stable/users/docker_installation/
  EOS
  end

end


