FORCE:
.PHONY: FORCE

build: FORCE
	@docker build -t tokibi/busybox-bundle-registry .

push: FORCE
	docker push tokibi/busybox-bundle-registry

registry: FORCE
	docker pull busybox:latest
	docker tag busybox:latest localhost:5000/busybox:latest
	docker tag busybox:latest localhost:5000/busybox:2.0.0-pre
	docker tag busybox:latest localhost:5000/busybox:1.0.1
	docker tag busybox:latest localhost:5000/busybox:1.0.0
	docker tag busybox:latest localhost:5000/busybox:0.1.0

	docker run -d -p 5000:5000 --rm --name tmp-registry registry:2
	docker push localhost:5000/busybox:latest
	docker push localhost:5000/busybox:2.0.0-pre
	docker push localhost:5000/busybox:1.0.1
	docker push localhost:5000/busybox:1.0.0
	docker push localhost:5000/busybox:0.1.0
	docker exec tmp-registry sh -c "cd /var/lib && tar -jcvf - registry" > ./registry.tar.bz2
	docker stop tmp-registry
	docker image rm localhost:5000/busybox:latest
	docker image rm localhost:5000/busybox:2.0.0-pre
	docker image rm localhost:5000/busybox:1.0.1
	docker image rm localhost:5000/busybox:1.0.0
	docker image rm localhost:5000/busybox:0.1.0
