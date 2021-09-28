class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.0.tar.gz"
  sha256 "c9880b23c8f8fde3b0b1b115880a03cdcfa13c341552d5b6c2fe10339ef59e02"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.0/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2b0e5286c30dfe19ac7888bc79eba8dbb101c38d31e0ea4bd5a84a831068a74b"
    sha256 cellar: :any_skip_relocation, high_sierra: "99d71dc132e62b7679116169ad551de7eff5dd2447bfa6b1f26cf251c4e7616d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "44bc5ffae28aa568dd6d836b482351f8568dec35bdf3ef8699507d34937ca206"
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
