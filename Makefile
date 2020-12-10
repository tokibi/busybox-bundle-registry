FORCE:
.PHONY: FORCE

build: FORCE
	@docker build -t tokibi/busybox-bundle-registry .

push: FORCE
	docker push tokibi/busybox-bundle-registry

registry: FORCE
	docker pull busybox:latest
	docker pull busybox:1.32.0-glibc
	docker pull busybox:1.31.0
	docker pull busybox:1.29.3
	docker tag busybox:latest localhost:5000/busybox:latest
	docker tag busybox:1.32.0-glibc localhost:5000/busybox:1.32.0-glibc
	docker tag busybox:1.32.0 localhost:5000/busybox:1.32.0
	docker tag busybox:1.29.3 localhost:5000/busybox:1.29.3

	docker run -d -p 5000:5000 --rm --name tmp-registry registry:2
	docker push localhost:5000/busybox:latest
	docker push localhost:5000/busybox:1.32.0-glibc
	docker push localhost:5000/busybox:1.32.0
	docker push localhost:5000/busybox:1.29.3
	docker exec tmp-registry sh -c "cd /var/lib && tar -jcvf - registry" > ./registry.tar.bz2
	docker stop tmp-registry
	docker image rm localhost:5000/busybox:latest
	docker image rm localhost:5000/busybox:1.32.0-glibc
	docker image rm localhost:5000/busybox:1.31.0
	docker image rm localhost:5000/busybox:1.29.3
