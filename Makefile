.PHONY: update-lock
update-lock:
	bazel run @trixie//:lock
