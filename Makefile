deb_packages.bzl:
	bazel run //deb-manager -- -conf $(CURDIR)/deb_packages.yaml -macro $(CURDIR)/private/deb/deb_pkg.bzl $(CURDIR)/deb_packages.bzl
