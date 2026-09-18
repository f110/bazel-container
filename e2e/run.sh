#!/usr/bin/env bash
set -euo pipefail

IMAGE="${E2E_IMAGE:-bazel-container:debian13}"
REPO="${E2E_REPO:-https://github.com/f110/heimdallr}"
REF="${E2E_REF:-master}"
BAZEL="${BAZEL:-bazel}"

workdir=""
cleanup() {
	if [ -n "$workdir" ]; then
		chmod -R u+w "$workdir" 2>/dev/null || true
		rm -rf "$workdir"
	fi
}
trap cleanup EXIT

if ! docker info >/dev/null 2>&1; then
	echo "docker daemon is not available" >&2
	exit 1
fi

if [ -z "${E2E_SKIP_BUILD:-}" ]; then
	echo "==> Loading the container image ($IMAGE)"
	"$BAZEL" run //:bazelisk.tar
fi

workdir="$(mktemp -d)"
src="$workdir/heimdallr"

echo "==> Cloning $REPO ($REF)"
git clone --depth 1 --branch "$REF" "$REPO" "$src"

echo "==> Running the test suite of heimdallr in the container"
# shellcheck disable=SC2086
docker run --rm \
	--platform linux/amd64 \
	-v "$src:/workspace" \
	-w /workspace \
	-e HOME=/root \
	-e LANG=C.UTF-8 \
	${E2E_DOCKER_ARGS:-} \
	"$IMAGE" \
	test //... \
	--config=ci \
	--platforms=@rules_go//go/toolchain:linux_amd64

echo "==> PASS"
