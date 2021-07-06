class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.7.tar.gz"
  sha256 "eff7bdd1ce952b4a20be576079569697ec8230f352d67c4095b2997cc7376eae"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.7/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "598a7c427806c569345a48845fe07c6a0badec8acfdd44656d9619caa79d95fe"
    sha256 cellar: :any_skip_relocation, high_sierra: "17a5f2e5d1b103e6381ef4fe80ca4ded195fd7deaa9e0ddd6fd05619448eaad5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2ef3a4c989c238590866888af1abcd1fc54cde97de4f9b47b29ff4e06c912857"
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
