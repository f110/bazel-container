BAZELISK_VERSION = "v1.28.0"
BAZELISK_CHECKSUM = "1d03e564dab205d7da72fbbf506679931ab2b33bc2bc92d1dc886dfedb6ef8a7"
BAZELISK_URL = "https://github.com/bazelbuild/bazelisk/releases/download/%s/bazelisk-linux-amd64" % BAZELISK_VERSION

def _bazelisk_binary_impl(ctx):
    ctx.download(
        url = BAZELISK_URL,
        sha256 = BAZELISK_CHECKSUM,
        output = ctx.path(ctx.original_name),
    )
    ctx.file("BUILD.bazel", 'filegroup(name = "file", srcs = ["bazelisk"], visibility = ["//visibility:public"])')

bazelisk_binary = repository_rule(
    implementation = _bazelisk_binary_impl,
    attrs = {},
)

def _bazelisk_impl(module_ctx):
    bazelisk_binary(name = "bazelisk")

bazelisk_extension = module_extension(
    tag_classes = {},
    implementation = _bazelisk_impl,
)
