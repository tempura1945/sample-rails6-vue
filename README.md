# rails6 + vueのサンプルアプリ
- 業務で利用することが多い、railsでのapiと管理画面（AdminLte）のベースを想定しています。
- 管理画面フロントは一部vue.jsで実装してあります。

## image
![image](https://github.com/takahashi1985/sample-rails6-vue/blob/main/imgs/sample.png)

## setup
- ruby v3.0.0
- node.js v14.15.3
- docker-compose
```
git clone https://github.com/takahashi1985/sample-rails6-vue
cd sample-rails6-vue
bundle install
yarn install
docker-compose up -d
rails db:migrate
rails db:seed
foreman start -f Procfile.local
```

## アクセス
- http://localhost:3000/admin/sign_in
```
email: test@example.com
password: password
```

## その他サンプル
[terraformのサンプルレポジトリ](https://github.com/takahashi1985/sample-infra)
