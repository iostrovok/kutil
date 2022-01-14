# Include go binaries into path
export PATH := $(GOPATH)/bin:$(PWD)/bin:$(PATH)

# teamcity
install: mod ## Run installing
	@echo "Environment installed"

tests-testing: ## Run test covering
	cd ./testing/ && $(SOURCE_PATH) go test -coverprofile=$(PWD)/coverage.out .
	go tool cover -html=coverage.out -o coverage-testing.html
	rm coverage.out

tests-keyutil: ## Run test covering
	cd ./keyutil/ && $(SOURCE_PATH) go test -coverprofile=$(PWD)/coverage.out .
	go tool cover -html=coverage.out -o coverage-keyutil.html
	rm coverage.out

tests-jsonpath: ## Run test covering
	cd ./jsonpath/ && $(SOURCE_PATH) go test -coverprofile=$(PWD)/coverage.out .
	go tool cover -html=coverage.out -o coverage-jsonpath.html
	rm coverage.out

tests-homedir: ## Run test covering
	cd ./homedir/ && $(SOURCE_PATH) go test -coverprofile=$(PWD)/coverage.out .
	go tool cover -html=coverage.out -o coverage-homedir.html
	rm coverage.out

tests-exec: ## Run test covering
	cd ./exec/ && $(SOURCE_PATH) go test -coverprofile=$(PWD)/coverage.out .
	go tool cover -html=coverage.out -o coverage-exec.html
	rm coverage.out

tests-connrotation: ## Run test covering
	cd ./connrotation/ && $(SOURCE_PATH) go test -coverprofile=$(PWD)/coverage.out .
	go tool cover -html=coverage.out -o coverage-connrotation.html
	rm coverage.out

tests-certificate: ## Run test covering
	cd ./certificate/ && $(SOURCE_PATH) go test -coverprofile=$(PWD)/coverage.out .
	go tool cover -html=coverage.out -o coverage-certificate.html
	rm coverage.out


test: tests-connrotation tests-exec tests-homedir tests-jsonpath tests-keyutil tests-testing


mod: ## Download all dependencies
	@echo "======================================================================"
	@echo "Run MOD...."

# 	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod verify
	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod tidy
	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod vendor
	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod download
# 	GO111MODULE=on GONOSUMDB="*" GOPROXY=direct go mod verify
	@echo "======================================================================"

clean_test:
	@echo "Run test artifact"
	rm ./coverage-*

clean_full: clean-vendor clean_test
	@echo "Run clean"
	go clean -i -r -x -cache -testcache -modcache

clean-vendor: ## Remove vendor folder
	@echo "clean-vendor started..."
	rm -fr ./vendor
	@echo "clean-vendor complete!"
