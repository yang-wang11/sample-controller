IMG ?= elan01/crontab:latest

all: test manager

# Run go fmt against code
fmt:
	go fmt ./pkg/... ./

clean: vendor
	go mod tidy

vendor:
	go mod vendor

# Run tests
test: fmt
	go test ./pkg/... . -coverprofile cover.out

# Build manager binary
manager: fmt clean
	CGO_ENABLED=0 GOOS=linux go build -o build/bin/crontab-operator .
	chmod +x build/bin/crontab-operator

run: fmt clean
	go run . -kubeconfig=${HOME}/.kube/config

# Build the docker image
docker-build: manager
	DOCKER_BUILDKIT=0 docker build ./build -t ${IMG}

# Push the docker image
docker-push:
	docker push ${IMG}

chart-tmp:
	helm template chart/crontab  | tee /tmp/chart.yaml

deploy:
	helm template chart/crontab  | kubectl apply -f -

undeploy:
	helm template chart/crontab  | kubectl delete -f -

