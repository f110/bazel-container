load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

VERSIONS = [
    (
        "4.2.1",
        "https://releases.bazel.build/4.2.1/release/bazel-4.2.1-linux-x86_64",
        "1a4f3a3ce292307bceeb44f459883859c793436d564b95319aacb8af1f20557c",
    ),
    (
        "4.2.0",
        "https://releases.bazel.build/4.2.0/release/bazel-4.2.0-linux-x86_64",
        "643f3cdc707fc27dad3e5eb4f97ed7fa8f2a132a5477fb4ac2eae3c52d7abb65",
    ),
    (
        "4.1.0",
        "https://releases.bazel.build/4.1.0/release/bazel-4.1.0-linux-x86_64",
        "0eb2e378d2782e7810753e2162245ad1179c1bb12f848c692b4a595b4edf779b",
    ),
    (
        "4.0.0",
        "https://releases.bazel.build/4.0.0/release/bazel-4.0.0-linux-x86_64",
        "7bee349a626281fc8b8d04a7a0b0358492712377400ab12533aeb39c2eb2b901",
    ),
    (
        "3.7.0",
        "https://releases.bazel.build/3.7.0/release/bazel-3.7.0-linux-x86_64",
        "b7583eec83cc38302997098a40b8c870c37e0ab971a83cb3364c754a178b74ec",
    ),
    (
        "3.6.0",
        "https://releases.bazel.build/3.6.0/release/bazel-3.6.0-linux-x86_64",
        "b2985c3ad1ec0284a66749b635ac11b323bc6b964d2cfcf33721746243a19530",
    ),
    (
        "3.5.1",
        "https://releases.bazel.build/3.5.1/release/bazel-3.5.1-linux-x86_64",
        "12b4ab9bf6957de33ad8c809efc27254c599217a37c5a68553b53ccde43d329a",
    ),
]

def bazel_binaries():
    for version_info in VERSIONS:
        http_file(
            name = "bazel_" + version_info[0].replace(".", "_"),
            sha256 = version_info[2],
            urls = [version_info[1]],
        )
