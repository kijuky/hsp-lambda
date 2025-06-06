# hsp-lambda

## 0. 準備

go-taskをインストール

```console
brew install go-task
```

.envを作成

```console
cp .env.example .env
```

`.env`の内容を必要に応じて変更します。

## 1. ビルド

```console
task build
```

`echo-lambda-hsp` イメージが作成されます。

## 2. デプロイ

### 2-1. 初回時

```console
task build create-iam-role create-ecr-repo push-image deploy-lambda
```

プロファイルに `lambda-execute-hsp` ロールを作成し、アタッチする。ecrリポジトリを作成し、先ほどビルドしたイメージをプッシュ。プッシュしたイメージをベースにラムダを作成。

## 3. 実行

```console
aws lambda invoke \
  --function-name ${AWS_LAMBDA_FUNCTION_NAME} \
  --invocation-type RequestResponse \
  --payload fileb://${EVENT_FILE} \
  --region ${AWS_REGION} \
  --profile ${AWS_PROFILE} \
  response.json && cat response.json
```

## 4. 破棄

いくつかのリソースは有料なので、使い終わったら破棄する。

```console
task cleanup-all
```

