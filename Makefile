FORCE:
.PHONY: FORCE

build: make-registry FORCE
	@docker build -t tokibi/busybox-bundle-registry .

push: FORCE
	docker push tokibi/busybox-bundle-registry

make-registry: FORCE
	docker pull busybox:latest
	docker tag busybox:latest localhost:5000/busybox:latest

	docker run -d -p 5000:5000 --rm --name tmp-registry registry:2
	docker push localhost:5000/busybox:latest
	docker exec tmp-registry sh -c "cd /var/lib && tar -jcvf - registry" > ./registry.tar.bz2
	docker stop tmp-registry
	docker image rm localhost:5000/busybox:latest
