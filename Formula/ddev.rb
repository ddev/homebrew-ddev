class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  url "https://github.com/rfay/ddev/releases/download/v0.5/ddev-darwin.tar.gz"
  sha256 "69ef77ef7b2f34ebcdc2207d71308742ab0b521d020eaf81d6d19e7645d2a252"

  # Dependencies don't currently seem to be useful since brew doesn't have edge and people likely will not have
  # used brew to install docker.
  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run

  depends_on "go" => :build

  #bottle do
    #root_url "http://thefays.us/tmp"
    #cellar :any_skip_relocation
    #rebuild 1
    #sha256 "116a8ebada06fa61da1181a1fed4b027e1cbd12ddc1c6b0fc339a39fe405be1f" => :sierra
  #end

  def install
  	p "I am in the install for sure"
  	tar zxf ddev-darwin.tar.gz
    bin.install_symlink "ddev/darwin/ddev"
  end


  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test ddev`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/ddev", "version"
  end
end


