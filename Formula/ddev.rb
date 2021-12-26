class Ddev < Formula
  desc "Local web development system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.2.tar.gz"
  sha256 "ecb60fe840eee12bb9ba1dfe5310eb9770d0c38fca3abf01c71cfe6edbfad92c"
  license "apache-2.0"

  head "https://github.com/drud/ddev.git", branch: "master"

  depends_on "mkcert" => :run
  depends_on "nss" => :run
  depends_on "go" => :build
  depends_on "make" => :build

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.2/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3504877505b4538df79dcf1098d114bf6449b45f6c1434a7b606cd5b3da48d63"
    sha256 cellar: :any_skip_relocation, high_sierra: "c6340da28629667b5e4ae493732ceed462f56978163cbabf74657f67863dd598"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c0b17b74907ab152ac7117c78f0d274591db7800ceb8b098caf486c2ce06dd8e"
  end
  def install
    system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
    system "mkdir", "-p", "#{bin}"
    if OS.mac?
        if Hardware::CPU.arm?
            system "cp", ".gotmp/bin/darwin_arm64/ddev", "#{bin}/ddev"
            system ".gotmp/bin/darwin_arm64/ddev_gen_autocomplete"
        else
            system "cp", ".gotmp/bin/darwin_amd64/ddev", "#{bin}/ddev"
            system ".gotmp/bin/darwin_amd64/ddev_gen_autocomplete"
        end
    end
    if OS.linux?
      system "cp", ".gotmp/bin/linux_amd64/ddev", "#{bin}/ddev"
      system ".gotmp/bin/linux_amd64/ddev_gen_autocomplete"
    end
    bash_completion.install ".gotmp/bin/ddev_bash_completion.sh" => "ddev"
    zsh_completion.install ".gotmp/bin/ddev_zsh_completion.sh" => "ddev"
    fish_completion.install ".gotmp/bin/ddev_fish_completion.sh" => "ddev"
  end

  def caveats
    <<~EOS
            Make sure to do a 'mkcert -install' if you haven't done it before, it may require your sudo password.
      #{"      "}
            ddev requires docker or colima.
            See https://ddev.readthedocs.io/en/latest/users/docker_installation/
    EOS
  end

  test do
    system "#{bin}/ddev", "--version"
  end
end
