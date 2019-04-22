class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.7.1.tar.gz"
  sha256 "afc6f895e31590ff68f84e0522adddda41f1ada39f626ab17d5cdb5cbc7a195a"

  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run
  depends_on "docker" => :build
  depends_on "go" => :build
  depends_on "mkcert" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.7.1/"
    cellar :any_skip_relocation
    sha256 "77d30797dc21765b509b5b4d9d5195aafcc4079e4cf802d48b03f108f75326d4" => :x86_64_linux
    sha256 "7371448ce7d9b3d301313075c3444ed1ea65a68bd1e038fb3c4707b0f78bc8a2" => :sierra
  end

  def install
    system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
    system "mkdir", "-p", "#{bin}"
    system "mkcert", "-install"
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
ddev requires docker and docker-compose.
Docker installation instructions at https://ddev.readthedocs.io/en/stable/users/docker_installation/
  EOS
  end

end


