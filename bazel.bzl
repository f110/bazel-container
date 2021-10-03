load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load(":versions.bzl", "VERSIONS")

def bazels():
    for version_info in VERSIONS:
        v = version_info[0].replace(".", "_")
        pkg_tar(
            name = "bazel_%s_bin" % v,
            files = {
                "@bazel_" + v + "//file": "/usr/local/bin/bazel",
            },
            mode = "0755",
        )

        container_image(
            name = "bazel_" + v,
            base = ":base_layer",
            entrypoint = ["/usr/local/bin/bazel"],
            labels = {
                "org.opencontainers.image.source": "https://github.com/f110/bazel-container",
            },
            tars = [
                ":bazel_" + v + "_bin",
            ],
        )
