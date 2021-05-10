
.server: server/*
	docker build -t server server
	touch $@

.runserver: .server
	docker run -p 3000:3000 --rm -d --name server server
	touch $@

testserver: .runserver
	curl http://localhost:3000/

stopserver:
	docker kill server
	rm .runserver

logs:
	docker logs server

.PHONY: testserver stopserver logs