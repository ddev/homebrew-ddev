class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.0.tar.gz"
  sha256 "24b575875402c8eb9bf07e5a53cd4163a454dac881dfffb9e77ef777373b5a3a"

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.0/"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8a587fb140a1db1fd58765328189b98d202cf20d1ebfd301eb40aa549fbfeb98"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1951c0405faf1df5ed55809cf63b917b5d5f43f89b173d5e7494ebe7ba18111"
    sha256 cellar: :any_skip_relocation, high_sierra:   "1f13b22940233a1c9bd8d56d5e3fee13446047fe9dd5b06cd505a4d4997d3bb3"
  end

  depends_on "mkcert" => :run
  depends_on "nss" => :run
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
