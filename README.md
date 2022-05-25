# gazeestimation-on-tao-toolkit
gazeestimation-on-tao-toolkit は、NVIDIA TAO TOOLKIT を用いて GazeEstimation の AIモデル最適化を行うマイクロサービスです。  

## 動作環境
- NVIDIA 
    - TAO TOOLKIT
- GazeEstimation
- Docker
- TensorRT Runtime

## GazeEstimationについて
GazeEstimation は、画像内の顔、顔の主なランドマークを検出し、視線位置と視線ベクトル推測するAIモデルです。

## 動作手順

### engineファイルの生成
GazeEstimation のAIモデルをデバイスに最適化するため、 GazeEstimation の .etlt ファイルを engine file に変換します。
engine fileへの変換は、Makefile に記載された以下のコマンドにより実行できます。

```
tao-convert:
	docker exec -it gazeestimation-tao-toolkit tao-converter -k nvidia_tlt -t fp16 -d 1,224,224 \
		-p input_right_images:0,1x1x224x224,8x1x224x224,8x1x224x224 -p input_left_images:0,1x1x1x224x224,1x8x1x224x224,1x8x1x224x224 \
		-p input_facegrid:0,1x1x1x625x1,1x8x1x625x1,1x8x1x625x1 -p input_face_images:0,1x1x1x224x224,1x8x1x224x224,1x8x1x224x224 \
		-e /app/src/gazeestimation.engine /app/src/model.etlt
```

## 相互依存関係にあるマイクロサービス  
本マイクロサービスで最適化された GazeEstimation の AIモデルを Deep Stream 上で動作させる手順は、[gazeestimation-on-deepstream](https://github.com/latonaio/gazeestimation-on-deepstream)を参照してください。  

## engineファイルについて
engineファイルである gazeestimation.engine は、[gazeestimation-on-deepstream](https://github.com/latonaio/gazeestimation-on-deepstream)と共通のファイルであり、本レポジトリで作成した engineファイルを、当該リポジトリで使用しています。  
