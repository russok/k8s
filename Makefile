
image_name=localhost:5000/node-server
port=3000

.server: server/*
	docker build -t $(image_name) server
	touch $@

.runserver: .server
	docker run -p $(port):$(port) --rm -d --name server $(image_name)
	touch $@

testserver: .runserver
	curl http://localhost:$(port)/

stopserver:
	docker kill server
	rm .runserver

logs:
	docker logs server

.PHONY: testserver stopserver logs

#-----------------------

.cluster: .server
	bash kind-with-registry.sh
	docker push $(image_name)
	kubectl config use-context kind-kind
	touch $@

delete-cluster:
	kind delete cluster
	docker kill kind-registry
	rm .cluster

deploy: .cluster
	kubectl apply -f hello-node-deployment.yaml
	kubectl apply -f hello-node-service.yaml

.PHONY: deploy delete-cluster
