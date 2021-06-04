class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.5.tar.gz"
  sha256 "6ab952228938d916887228abcb3684a8ec1216f63c4e9e6a855f3d99868c8b05"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.5/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4de538c6d533c2df062fbb14ab90a60324719d91f79509e2c449dc35bb1966c5"
    sha256 cellar: :any_skip_relocation, high_sierra: "62367587c0ca901a85464d8e3a56288e9b75bc5e593bfd1673408b3a7ae1486e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "badf9f13766ec2c3ef28a4f28e882c636084693f1197ea777f6129a9844caeb2"
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
