class Ddev < Formula
  desc "ddev: a local development environment management system"
  homepage "https://ddev.readthedocs.io/en/latest/"
  url "https://drud.bintray.com/ddev/v0.9.3/ddev_osx.v0.9.3.tar.gz"
  sha256 "2cbbe0048c072833e5adb505f62cd4387a76bfc20997c1e581745a887e7f6023"

  # Dependencies don't currently seem to be useful since brew doesn't have edge and people likely will not have
  # used brew to install docker.
  # depends_on "docker" => :run
  # depends_on "docker-compose" => :run

  def install
  	system "mkdir", "-p", "#{bin}"
  	system "cp", "ddev", "#{bin}/ddev"
	bash_completion.install "ddev_bash_completion.sh" => "ddev"
  end

  test do
    system "#{bin}/ddev", "version"
  end
end


