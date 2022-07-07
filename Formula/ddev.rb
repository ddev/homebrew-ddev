class Ddev < Formula
  desc "Local web development system"
  homepage "https://ddev.readthedocs.io/"
  url "https://github.com/drud/ddev/archive/v1.19.3.tar.gz"
  sha256 "d8cffc60cfd795bc6cb4505983d6f7dd986ee4fd3fcc4d3100706f56bbf1a625"
  license "apache-2.0"
  head "https://github.com/drud/ddev.git", branch: "master"

  depends_on "mkcert" => :run
  depends_on "nss" => :run
  depends_on "go" => :build
  depends_on "make" => :build

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.19.3/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0998bf2b60a349e370f0312f10cc516fb381d082cb355f16e3d694b47b7daacd"
    sha256 cellar: :any_skip_relocation, high_sierra: "4c7457930eae49b8af42c7714a9b6017d8606f972a9165d8cb118d6c087e2d8c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "475dec25d4fbde8e8d4659cd436a18112b843f60553ab9cb9534e1a496017975"
  end
  on_macos do
    if Hardware::CPU.intel?
#       url "https://github.com/rfay/ddev/releases/download/v1.19.4-aj2/ddev_macos-amd64.v1.19.4-aj2.tar.gz"
#       sha256 "fa7dfa5bd942d9629ad8df6c07cb5e2f4b337fac1b27dbbbf71596c1f9aa1922"

      def install
        if build.head?
            os = OS.mac? ? "darwin" : "linux"
            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            system "mkdir", "-p", "#{bin}"
            system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
            system "cp", ".gotmp/bin/" + os + "_" + arch + "/ddev", "#{bin}/ddev"
        else
            bin.install "ddev"
            bash_completion.install "ddev_bash_completion.sh" => "ddev"
            zsh_completion.install "ddev_zsh_completion.sh" => "ddev"
            fish_completion.install "ddev_fish_completion.sh" => "ddev"
        end
      end
    end
    if Hardware::CPU.arm?
#       url "https://github.com/rfay/ddev/releases/download/v1.19.4-aj2/ddev_macos-arm64.v1.19.4-aj2.tar.gz"
#       sha256 "5351238d036fb6c4e2d9f59b75d5a9efbdf0c51a6e6dfa328a85e81c9b0ff087"

      def install
        if build.head?
            os = OS.mac? ? "darwin" : "linux"
            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            system "mkdir", "-p", "#{bin}"
            system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
            system "cp", ".gotmp/bin/" + os + "_" + arch + "/ddev", "#{bin}/ddev"
        else
            bin.install "ddev"
            bash_completion.install "ddev_bash_completion.sh" => "ddev"
            zsh_completion.install "ddev_zsh_completion.sh" => "ddev"
            fish_completion.install "ddev_fish_completion.sh" => "ddev"
        end
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
#       url "https://github.com/rfay/ddev/releases/download/v1.19.4-aj2/ddev_linux-arm64.v1.19.4-aj2.tar.gz"
#       sha256 "ab40424b854f128537a2d497f955131c4a704539ac0398da4a35082a8cf690ef"

      def install
        if build.head?
            os = OS.mac? ? "darwin" : "linux"
            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            system "mkdir", "-p", "#{bin}"
            system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
            system "cp", ".gotmp/bin/" + os + "_" + arch + "/ddev", "#{bin}/ddev"
        else
            bin.install "ddev"
            bash_completion.install "ddev_bash_completion.sh" => "ddev"
            zsh_completion.install "ddev_zsh_completion.sh" => "ddev"
            fish_completion.install "ddev_fish_completion.sh" => "ddev"
        end
      end
    end
    if Hardware::CPU.intel?
#       url "https://github.com/rfay/ddev/releases/download/v1.19.4-aj2/ddev_linux-amd64.v1.19.4-aj2.tar.gz"
#       sha256 "76076e272e1fa48415eff7a36259cf5d9f7d49d693980dc4ccadb9e186586404"

      def install
        if build.head?
            os = OS.mac? ? "darwin" : "linux"
            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            system "mkdir", "-p", "#{bin}"
            system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
            system "cp", ".gotmp/bin/" + os + "_" + arch + "/ddev", "#{bin}/ddev"
        else
            bin.install "ddev"
            bash_completion.install "ddev_bash_completion.sh" => "ddev"
            zsh_completion.install "ddev_zsh_completion.sh" => "ddev"
            fish_completion.install "ddev_fish_completion.sh" => "ddev"
        end
      end
    end
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
