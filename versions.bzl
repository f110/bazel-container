load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

VERSIONS = [
    (
        "5.3.1",
        "https://releases.bazel.build/5.3.1/release/bazel-5.3.1-linux-x86_64",
        "f680a8a35789fb550c966a9a6661349af6993edd5ebf85bfb0f22e968c78115a",
    ),
    (
        "5.3.0",
        "https://releases.bazel.build/5.3.0/release/bazel-5.3.0-linux-x86_64",
        "3d144b890b85d95fb13df941bfd010fc3628e9afaa4c85e7d1a002e4fd02b249",
    ),
    (
        "5.2.0",
        "https://releases.bazel.build/5.2.0/release/bazel-5.2.0-linux-x86_64",
        "ae6944cf23baa5218fdb5f6d0ad7a7cf63c5b71eb463f47775e3f64828d340af",
    ),
    (
        "5.1.1",
        "https://releases.bazel.build/5.1.1/release/bazel-5.1.1-linux-x86_64",
        "5e126060d9169b462a18e97435356c3b3712d20fdbef9ac7609016838a90e7d3",
    ),
    (
        "5.1.0",
        "https://releases.bazel.build/5.1.0/release/bazel-5.1.0-linux-x86_64",
        "0440ae4581ea5eac5cb36ed0790b1e942778eb81e3ba9bc1326f189427aef0fd",
    ),
    (
        "5.0.0",
        "https://releases.bazel.build/5.0.0/release/bazel-5.0.0-linux-x86_64",
        "399eedb225cff7a13f9f027f7ea2aad02ddb668a8eb89b1d975d222e4dc12ed9",
    ),
    (
        "4.2.2",
        "https://releases.bazel.build/4.2.2/release/bazel-4.2.2-linux-x86_64",
        "11dea6c7cfd866ed520af19a6bb1d952f3e9f4ee60ffe84e63c0825d95cb5859",
    ),
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
    (
        "3.4.1",
        "https://releases.bazel.build/3.4.1/release/bazel-3.4.1-linux-x86_64",
        "1a64c807716e10c872f1618852d95f4893d81667fe6e691ef696489103c9b460",
    ),
]

def bazel_binaries():
    for version_info in VERSIONS:
        http_file(
            name = "bazel_" + version_info[0].replace(".", "_"),
            sha256 = version_info[2],
            urls = [version_info[1]],
        )
