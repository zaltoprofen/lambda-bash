# lambda-bash
Shellscript on AWS Lambda

re:Invent 2020で公開されたLambdaのコンテナサポートを利用してLambda上でBashスクリプトを動かし、Hello worldを行うコード

## 前提条件

- AWS CLIがセットアップ完了している
- Serverless Frameworkの最新版がインストールされている

## セットアップ方法

まず、ECRにレポジトリを作ります。

```
./create_repository.sh
```

コンテナイメージをビルドしてECRにイメージをプッシュします。
```
./build-and-push.sh
```

Serverless Frameworkでdeployを実行する。
```
sls deploy
```

## 動作確認方法
Serverless Frameworkの出力結果に以下のような行があるので、そのURLに対してcurlなどでリクエストを実行する。

```
endpoints:
  GET - https://xxxxxxxx.execute-api.ap-northeast-1.amazonaws.com/dev/hello
```

```
$ curl https://xxxxxxxx.execute-api.ap-northeast-1.amazonaws.com/dev/hello
Hello world!
```
