# Keycloak

## 概要

Keycloak を Docker コンテナでセルフホスト可能なようにしたものです。
コンテナを立ち上げると、Keycloak Admin REST API を実行できるようになります。

## ポートマッピング

| コンテナ名       | ポート |
| ---------------- | ------ |
| exp-keycloak-db  | 20001  |
| exp-keycloak-app | 10001  |

## 起動

コンテナを起動

```bash
make up
```

Keycloak 管理画面にアクセス

http://localhost:10001

## 設定

### Keycloak の設定

※コンテナ起動時は下記設定は不要 (備忘録として記載)。

※ Admin REST API の使用に際して、Client の作成は不要。

master 以外の Realm を作成する (eg. fts-experimental)。  
Clients > admin-cli > Settings > Capability config で以下を設定。

- Client authentication > On
- Authorization > Off
- Authentication flow > Service accounts roles のみ On

admin-cli の Service accounts roles > Assign role で以下を設定。

- manage-users > Assign

Credentials > Client Secret をコピーする。

### 動作確認

[Postman の設定例 (json ファイル)](./config/postman.json)

1. アクセストークンを取得する

```bash
curl --location 'http://localhost:10001/realms/fts-experimental/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=admin-cli' \
--data-urlencode 'client_secret=DUMMY_CLIENT_SECRET'
```

2. アクセストークンを使用して API を呼び出す

```bash
curl --location 'http://localhost:10001/admin/realms/fts-experimental/users' \
--header 'Authorization: Bearer DUMMY_ACCESS_TOKEN'
```
