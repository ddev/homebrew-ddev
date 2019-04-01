class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.7.0.tar.gz"
  sha256 "12ae503d324b88cc2d6452c8909b86e82cfe7401ddc5993cec64ec16d7a095ac"

  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run
  depends_on "docker" => :build
  depends_on "go" => :build

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.7.0/"
    cellar :any_skip_relocation
    sha256 "030743d185409164611b4bbf872a3a39eed4865542060e8b2626c21075fcc94c" => :x86_64_linux
    sha256 "b2536dee295536867d0f25f4634a7604b040056d1341c86eaeed2eb1f699959d" => :sierra
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


