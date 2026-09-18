# bazel-container

bazel-container is an unofficial container for running [Bazel](https://bazel.build).

The bazel project does not publish a container officially.
But they have plans to release an official container.

This container is intended to be used in my workflow until the official container is published.
Hence, It is not guaranteed to work all of the rules maintained by the bazel project and others.

Feel free to use it in your workflow and the patch is welcome!

## ghcr.io/f110/bazel-container:bazelisk

Deprecated.

This container is built with chisel based on Ubuntu.

## ghcr.io/f110/bazel-container:bazelisk-debian13

This container is based on Debian13.

## E2E test

The e2e test verifies that the built container image can actually build and test a real repository.
It builds the image, loads it into docker, clones [heimdallr](https://github.com/f110/heimdallr) and runs its test suite inside the container.

Docker is required. This test can not run on CI for now.

```console
$ make e2e
```

The bazel cache is discarded on every run, so a full run takes a while.
On arm64 hosts the image runs under emulation because the image is built for `linux/amd64` only.

The following environment variables are available.

| Name              | Default                              | Description                                      |
|-------------------|--------------------------------------|--------------------------------------------------|
| `E2E_IMAGE`       | `bazel-container:debian13`           | The image to test.                               |
| `E2E_REPO`        | `https://github.com/f110/heimdallr`  | The repository to build.                         |
| `E2E_REF`         | `master`                             | The branch or tag to clone.                      |
| `E2E_SKIP_BUILD`  |                                      | If set, skips building and loading the image.    |
| `E2E_DOCKER_ARGS` |                                      | Extra arguments passed to `docker run`.          |

Do not mount a host directory as the bazel cache on macOS.
Globbing the Go SDK tree over the bind mount fails with `ENOENT` and the analysis phase breaks.
