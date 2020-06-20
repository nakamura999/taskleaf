# タスク管理

## バックエンド
- Ruby 2.7.0
- Rails 5.2.4.2

## 開発環境
- データベース / postgresql
- rbenv

### 機能
- 「gem device」を使わずログイン機能の実装
- タスク作成時に確認画面を挟む
- タスク検索機能 (gem ransack)　タスク名称ソート
- タスク画像登録機能(active storage)
- タスク「csvファイル」として出力(エクスポート)
- ページネーション(日本語化gem kaminari)
- タスクカーソル合わせ時色変更(js)
- destroy非同期