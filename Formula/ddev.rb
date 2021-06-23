class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.6.tar.gz"
  sha256 "096ba714128ec80309e911a4cb7cc4db0d8f19bc5b5ec2460bddbd3e350f2396"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.6/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "75f9b5c3bdee83e03c6e7e55b62d618ccb8d0dbcd57bc820f0ffacec5721cfc9"
    sha256 cellar: :any_skip_relocation, high_sierra: "d317857fb62c3223a2e76c5516e994818ab92797a672410040bdcab10732b765"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a5e8496b31055acf90be7ec817234d03a19ae58c3b27444cc726beff3af79896"
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
