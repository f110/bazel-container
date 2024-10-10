deb_packages.bzl: deb_packages.yaml
	bazel run //deb-manager -- -conf $(CURDIR)/deb_packages.yaml -macro $(CURDIR)/private/deb/deb_pkg.bzl $(CURDIR)/deb_packages.bzl

tmp/go.mod:
	bazel build @com_github_canonical_chisel//...
	mkdir tmp
	cp bazel-bazel-container/external/com_github_canonical_chisel/go.mod $@

chisel.bzl: tmp/go.mod
	bazel run //:gazelle -- update-repos -from_file=tmp/go.mod -to_macro=chisel.bzl%chisel_dependencies
	rm -rf tmp/go.mod
