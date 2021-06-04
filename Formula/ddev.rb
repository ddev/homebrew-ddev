class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.4.tar.gz"
  sha256 "342a098752cddf97dd85b7b2be761247078c886d60624c3807e891adf9207008"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.4/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aafedd6e9d7eccb97e38ddab522587d7379ac6eff6d88a8d77c100249f3ac574"
    sha256 cellar: :any_skip_relocation, high_sierra: "2547a3120295a0690a43a8b68f81edf1ecb533afb84074622552edf15f151ebe"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cae3bfdb4099938784f1415c6c622cabd5d91b5207e052d07ab5faa1dd401657"
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
