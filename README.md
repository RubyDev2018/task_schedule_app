# Task Share App

タスク管理のシェアを行い、お互いに目標達成のための意識づけを行う

・herokuへのデプロイ
https://taskmanagementsapp.herokuapp.com/

## アプリケーションの機能
- 基本的なCRUD処理
- 募集欄へのコメント投稿
- Rakeタスクを使ったCSVデータのインポート
- 各Userへのメール送信
- 良いね機能
- Userフォロー機能
- gemを使った下記の機能追加
  -  ログイン・ログアウト機能
  -  管理ユーザーの登録・ログイン機能
  -  ページネーション機能
  -  検索機能
  -  Twitterログイン機能
  -  画像ファイルのアップロード
  -  環境変数の管理
- 簡単なテストコードをRspecで記述

## 使用している技術
- Ruby version 2.5.3
- Rails version 5.2.3
- Docker
- CircleCI
- RSpec
- データベース development → MySQL,  production → PostgreSQL
- デプロイ heroku
- SendGrid を使用したメール送信機能
- AWSデプロイで使用している技術
  -  VPC
  -  EC2
  -  RDS for MySQL
  -  Route53
  -  ALB
  -  ACM
  -  S3
- GitHub 一人でですが、GitHub Flowの実施
