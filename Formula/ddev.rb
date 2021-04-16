class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.1.tar.gz"
  sha256 "6af19c13969189d0d77a5b5aab5bb784f17c2acb87c4b6b380b5a62b63db78f9"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.1/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d5b53ee613d28f90540bb20a6cc70b457946ff8b64e4aae428d348ea49ffde41"
    sha256 cellar: :any_skip_relocation, high_sierra: "28bca291599c56bec6b430193c7728ee595623ee5e46536f4430606bdddc2998"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "803a3c50f0ec91ac44ea17e93243f1d8923b0715db1c41e0532d733c7ba1972a"
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
