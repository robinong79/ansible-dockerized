all: help


.PHONY: build
build: build-stable build-devel ## Run all build-* rules

.PHONY: build-stable
build-stable: ## Build latest Ansible stable release
	./scripts/build-stable.sh

.PHONY: build-devel
build-devel: ## Build devel Ansible from Git
	./scripts/build-devel.sh


.PHONY: push
push: ## Push builded images
	./scripts/push.sh

# .PHONY: latest-versions
# latest-versions: ## Checks all the latest versions of the Dockerfile contents.
# 	./scripts/latest-versions.sh



.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
