BAZELISK_VERSION = "v1.30.0"
BAZELISK_CHECKSUM = "a248ae2b2b62b5baebb748f6fba7203bff1a27e5d01b55399a8406744cb539e8"
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
