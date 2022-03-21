class Ddev < Formula
  desc "Local web development system"
  homepage "https://ddev.readthedocs.io/"
  url "https://github.com/drud/ddev/archive/v1.19.1.tar.gz"
  sha256 "27905ea041eedb917846cd9a27faf4d6f180e4ebc07b3feb96e22426223b86f4"
  license "apache-2.0"
  head "https://github.com/drud/ddev.git", branch: "master"

  depends_on "mkcert" => :run
  depends_on "nss" => :run
  depends_on "go" => :build
  depends_on "make" => :build

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.19.1/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2b35e894bd5dc6988a2a0c7692c89ae47b74ea886e99bf806a1fd17a3286609d"
    sha256 cellar: :any_skip_relocation, high_sierra: "d468f4366ff18077f907129688bd96e11bba9999844ae8eb1f9ecfc498ce2711"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d55d03690f051387d0272094616eef8852fea0b1b05ac08454614e4cf0bcb139"
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
