# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  # url "https://github.com/drud/ddev/archive/v0.5.tar.gz"
  sha256 "6f673ade900a4c1b71c03fe4272a9876f8837e2e749afcb4109ec61a6488ec10"

  # Dependencies don't currently seem to be useful since brew doesn't have edge and people likely will not have
  # used brew to install docker.
  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run

  depends_on "go" => :build


  bottle do
    root_url "http://thefays.us/tmp"
    sha256 "6f673ade900a4c1b71c03fe4272a9876f8837e2e749afcb4109ec61a6488ec10" => :sierra
  end

  def install
  	p "I am in the install for sure"
    bin.install Dir["*"]
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


