load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "1f4e59843b61981a96835dc4ac377ad4da9f8c334ebe5e0bb3f58f80c09735f4",
    strip_prefix = "rules_docker-0.19.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.19.0/rules_docker-v0.19.0.tar.gz"],
)

http_archive(
    name = "rules_pkg",
    sha256 = "a89e203d3cf264e564fcb96b6e06dd70bc0557356eb48400ce4b5d97c2c3720d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
    ],
)

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

container_pull(
    name = "debian11",
    digest = "sha256:2c22645bfe97aa1ed1c930adf5970fee3454f9a42a19214051ec677cba805712",
    registry = "index.docker.io",
    repository = "library/debian",
)

http_file(
    name = "bazelisk",
    sha256 = "4cb534c52cdd47a6223d4596d530e7c9c785438ab3b0a49ff347e991c210b2cd",
    urls = ["https://github.com/bazelbuild/bazelisk/releases/download/v1.10.1/bazelisk-linux-amd64"],
)

http_file(
    name = "dep_pkgs",
    sha256 = "7695f759074d678ac8642ba6a94f2053d0b1069461dd408a4c005bd23851ba39",
    urls = ["https://github.com/f110/bazel-container/releases/download/dep_pkgs%2F20211002/dep_pkgs.tar"],
)

load(":versions.bzl", "bazel_binaries")

bazel_binaries()

http_file(
    name = "bazel_4_0_0",
    sha256 = "7bee349a626281fc8b8d04a7a0b0358492712377400ab12533aeb39c2eb2b901",
    urls = ["https://releases.bazel.build/4.0.0/release/bazel-4.0.0-linux-x86_64"],
)
