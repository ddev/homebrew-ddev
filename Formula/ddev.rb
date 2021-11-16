class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.1.tar.gz"
  sha256 "50806e9b6aad81f96d9e7a12373d16a7c7352d1d2499b1fe4b459451a1a52c4f"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.1/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "002c704d2ce03a987ac4878f9e692e37d72a96b4ee226e629e28cb2fa866e4a0"
    sha256 cellar: :any_skip_relocation, high_sierra: "3096c880acf38556446216982b123ae5136bbfe805a8cf5679c4cbe6d8da8d55"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "559f0249d5fd6a3230b538a2f1e8b58f9d3b57ef4eb3fcaf33bf638a9b82c4e9"
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
