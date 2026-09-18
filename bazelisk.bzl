BAZELISK_VERSION = "v1.29.0"
BAZELISK_CHECKSUM = "5a408715e932c0250d28bd84555f12edbf70117de42f9181691c736eacc4a992"
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
