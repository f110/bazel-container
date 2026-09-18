.PHONY: update-lock
update-lock:
	bazel mod deps --lockfile_mode=refresh

.PHONY: e2e
e2e:
	./e2e/run.sh
