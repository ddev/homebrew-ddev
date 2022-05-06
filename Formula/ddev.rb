class Ddev < Formula
  desc "Local web development system"
  homepage "https://ddev.readthedocs.io/"
  url "https://github.com/drud/ddev/archive/v1.19.2.tar.gz"
  sha256 "6d128676683acf6b4a92c762e434c4b6c3983471a65c30d2e0afcbbcb2e35e6a"
  license "apache-2.0"
  head "https://github.com/drud/ddev.git", branch: "master"

  depends_on "mkcert" => :run
  depends_on "nss" => :run
  depends_on "go" => :build
  depends_on "make" => :build

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.19.2/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4431c3e339ac7927068f8a88fd5c856c38a7b9d8efdf247f1ede3109114c8f7b"
    sha256 cellar: :any_skip_relocation, high_sierra: "25f789e230cd6de7219c6c0844c9eadba224816de0c49e3051ed8ee99ab75326"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "611a0c69981b5ee1f4a48f4ef810743bccbbff4e57e2b6c3d8e1680108d5a03b"
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
