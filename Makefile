.PHONY: update-lock
update-lock:
	bazel mod deps --lockfile_mode=refresh
