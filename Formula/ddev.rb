class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.3.tar.gz"
  sha256 "ca5817ded60f7b0bda9e014d0e26ea32c7a8361efc83c61f1b6360b6f2bc1644"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.3/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f60a2b0419e9a417eb0a0a761d57a2e61f6ef017c640865903d19ad03f004120"
    sha256 cellar: :any_skip_relocation, high_sierra: "8de7abfba3f6bb26eca6cda2ada891cf9df9020b50e813b450a00b3153738e62"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2c86d14a9da7e5dc1dd9e984f5379e3c535b784473786d5afc3a257b589848d6"
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
