# HOST systemd 用README

systemd を利用してHOST起動時にDocker コンテナ立ち上げからROSノード起動までを自動実行する。

## フォルダ構成

```
.
|- ros2_launch_service    ：serviceの設定
|- ros2_launch_sh         ：serviceから呼び出す実行ファイル
|- setup.sh               ：serviceの登録用シェルスクリプト
```

## 実行方法

git pullして来たら以下を実行

```bash
./setup.sh
```

## 拡張方法

新しいros2 パッケージを導入するとき

- 1_launcher/launch_<package>.sh を追加（書き方は他のlaunchファイル参照）
- ros2_launch_<project_name>_sh を書き足す（書き足し方は既に書いてある中身参照）

ros2_launch_serviceはsystemd の設定を変更する必要がある場合以外触らなくてOK

## 詳細

ros2 run までの自動実行の流れ

HOST上
systemd => ros2_launch.service => ros2_launch.sh => docker compose up => docker-compose.yml:common =>

DOCKER上
entrypoint:command => launch_<package>.sh => ros2 run
