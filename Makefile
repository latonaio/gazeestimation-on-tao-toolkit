# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

tao-docker-run: ## TAO用コンテナを建てる
	docker-compose -f docker-compose.yaml up -d

tao-docker-build: ## TAO用コンテナをビルド
	docker-compose -f docker-compose.yaml build

tao-convert:
	docker exec -it gazeestimation-tao-toolkit tao-converter -k nvidia_tlt -t fp16 -d 1,224,224 \
		-p input_right_images:0,1x1x224x224,8x1x224x224,8x1x224x224 -p input_left_images:0,1x1x1x224x224,1x8x1x224x224,1x8x1x224x224 \
		-p input_facegrid:0,1x1x1x625x1,1x8x1x625x1,1x8x1x625x1 -p input_face_images:0,1x1x1x224x224,1x8x1x224x224,1x8x1x224x224 \
		-e /app/src/gazeestimation.engine /app/src/model.etlt

tao-docker-login: ## TAO用コンテナにログイン
	docker exec -it gazeestimation-tao-toolkit bash

