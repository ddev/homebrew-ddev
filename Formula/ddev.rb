class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.7.1.tar.gz"
  sha256 "afc6f895e31590ff68f84e0522adddda41f1ada39f626ab17d5cdb5cbc7a195a"

  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run
  depends_on "docker" => :build
  depends_on "go" => :build

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.7.1/"
    cellar :any_skip_relocation
    sha256 "b4c639ebb5737c2991bd9f0855563adf58c4dd4249a8bf9aa2ced617ecf3bb8e" => :x86_64_linux
    sha256 "6480d036b1d78f273da261d631d52384b403aa03d696174396aa177d0bd4cba7" => :sierra
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
ddev requires docker and docker-compose.
Docker installation instructions at https://ddev.readthedocs.io/en/latest/users/docker_installation/
  EOS
  end

end


