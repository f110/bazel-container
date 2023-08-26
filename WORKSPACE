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
    name = "docker_gpg",
    downloaded_file_path = "docker_gpg",
    sha256 = "1500c1f56fa9e26b9b8f42452a553675796ade0807cdce11975eb98170b3a570",
    urls = ["https://download.docker.com/linux/debian/gpg"],
)

http_file(
    name = "bazelisk",
    sha256 = "ce52caa51ef9e509fb6b7e5ad892e5cf10feb0794b0aed4d2f36adb00a1a2779",
    urls = ["https://github.com/bazelbuild/bazelisk/releases/download/v1.18.0/bazelisk-linux-amd64"],
)

http_file(
    name = "dep_pkgs",
    sha256 = "2d7e3843914415530c999f239e4440ef691c59a82a98df3c6d761d3029fa5c66",
    urls = ["https://github.com/f110/bazel-container/releases/download/dep_pkgs%2F20211005/dep_pkgs.tar"],
)

load(":versions.bzl", "bazel_binaries")

bazel_binaries()
