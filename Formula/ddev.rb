class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.2.tar.gz"
  sha256 "2f713184ff05ee8bc0bd8f61bef3c3db7097713b10d3dac7d49cfe9a63e1170e"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.2/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "43016761c645252dc989612c219c4bc286cb10a5deeaa2a55c8acc7721e287b4"
    sha256 cellar: :any_skip_relocation, high_sierra: "46d017a1ae06315e64ae3341e63c09a114721e6cd79631438a853bcc445c10c9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "15a4fe66cba38d0443cad5408b6b5c84052cfec19fac5e9fee747454858dc9c1"
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
    zsh_completion.install ".gotmp/bin/ddev_zsh_completion.sh" => "ddev"
    fish_completion.install ".gotmp/bin/ddev_fish_completion.sh" => "ddev"
  end

  def caveats
    <<~EOS
            Make sure to do a 'mkcert -install' if you haven't done it before, it may require your sudo password.
      #{"      "}
            ddev requires docker and docker-compose.
            Docker installation instructions at https://ddev.readthedocs.io/en/stable/users/docker_installation/
    EOS
  end

  test do
    system "#{bin}/ddev", "--version"
  end
end
