BASE_IMG=hackedu/huginn
WEB_IMG=$(BASE_IMG)-web
JOBS_IMG=$(BASE_IMG)-jobs
BUILD_CMD=docker build
PUSH_CMD=docker push

.PHONY: build push

base:
	$(BUILD_CMD) -t $(BASE_IMG) .

web:
	$(BUILD_CMD) -t $(WEB_IMG) - < Dockerfile.web

jobs:
	$(BUILD_CMD) -t $(JOBS_IMG) - < Dockerfile.jobs

build: base web jobs

push: build
	$(PUSH_CMD) $(BASE_IMG)
	$(PUSH_CMD) $(WEB_IMG)
	$(PUSH_CMD) $(JOBS_IMG)
