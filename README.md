# drud/ddev Homebrew and Linuxbrew Formulas

This formula can build the ddev package from source or pull from bottles.

Updating:

* Add the url and sha256 of the new release source-code tarball to the homebrew-ddev local version.
* Create new bottles on linux and macOS (before pushing new formula:
```
   brew uninstall ddev
   cd homebrew-ddev  # directory with new source tarball/hash
   brew install --build-bottle Formulas/ddev.rb`
   brew bottle ddev
```
* Add the bottles into the formula per the output of `brew bottle`. 
* Create the new version number on bintray.com (drud org, ddev project)
* Push the new bottles; note that the name changes from high_sierra to el_capitan with the macOS version, and that the "--" changes to "-" inexplicably: 
  `curl -T ddev--<version>.x86_64_linux.bottle.tar.gz -urfay:b5e3b1b50e3ef9255140f5fd444d1e4029ece4da https://api.bintray.com/content/drud/bottles-ddev/ddev/v<version>/ddev-<version>.x86_64_linux.bottle.tar.gz`
  `curl -T ddev--1.5.1.high_sierra.bottle.tar.gz -urfay:b5e3b1b50e3ef9255140f5fd444d1e4029ece4da https://api.bintray.com/content/drud/bottles-ddev/ddev/v1.5.1/ddev-1.5.1.el_capitan.bottle.tar.gz`
* Publish the files on bintray.com.
* Create the PR for the new homebrew version.

I'm quite sure we'll automate most of this, but this is the documented process at this time.

You should be able to build from source any time using `brew reinstall --build-from-source ddev`