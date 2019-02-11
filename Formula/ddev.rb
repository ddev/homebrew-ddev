class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.6.0.tar.gz"
  sha256 "3eec12f97970e9a5326bb8e3943e12b2f03b049a1cd476ade4e3a8092da9dad4"

  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run
  depends_on "docker" => :build
  depends_on "go" => :build

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.6.0/"
    cellar :any_skip_relocation
    sha256 "aefe3fbb7f57b018b55c6599edd48e34acc32ad07a10527d1020ca835e594bfe" => :x86_64_linux
    sha256 "b290aab5ba273715b42e469b2c982b52b0f7375604959c0233cc1682bd34bd38" => :el_capitan
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
  end

  test do
    system "#{bin}/ddev", "version"
  end

  def caveats
  <<~EOS
ddev requires docker and docker-compose.
Docker installation instructions at https://ddev.readthedocs.io/en/latest/users/docker_installation/
  EOS
  end

end


