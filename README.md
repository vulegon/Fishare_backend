# README
## 始め方
下記より、セットアップ可能です。
また、このリポジトリはAPIのみなので下記とセットで動きます。
https://github.com/vulegon/fishare_front

```
git clone git@github.com:vulegon/fishare_backend.git
docker-compose build
docker-compose up -d
docker-compose exec api rails db:create db:migrate db:seed
```
問題なく実行できたら下記にアクセスして接続を確認します。
http://localhost:3001
