IMAGE_NAME=danilovbarbosa/dio-k8s-backend:1.0
APP_PATH=app
BACKEND_PATH=backend


build:
	@docker build -f backend/Dockerfile ./${BACKEND_PATH} -t ${IMAGE_NAME}

check-build:
	@docker inspect --type=image ${IMAGE_NAME} > /dev/null || make build

run:
	@make check-build
	@docker run -it --rm --env-file .env \
		-v ${PWD}/${BACKEND_PATH}:/${APP_PATH} \
		-w /${APP_PATH} \
		-p 8080:80 \
		${IMAGE_NAME}

shell:
	@make check-build
	@docker run -it --rm --env-file .env \
		-v ${PWD}/${BACKEND_PATH}:/${APP_PATH} \
		-w /${APP_PATH} \
		${IMAGE_NAME} \
		bash

clean:
	@docker rmi ${IMAGE_NAME} 