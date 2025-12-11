# docker image関係機能

```bash
build   => dbuild
rename => dcommit
pull/push  => dpull/ dpush
colcon build => build_project
up  => dup
```

## 方針：kasekiguchi/acsl-commonには不要にtagを増やさない

ベース系だけ　humble/humble_x86, jazzy/jazzy_x86 など
image_rf_robot などはbase イメージからプロジェクトのデプロイ時や setupコマンドで作成・更新する

## ベースイメージの作成

```bash
ROS_DISTRO=jazzy dbuild arm64v8/ros:jazzy jazzy  $ACSL_ROS2_DIR/3_dockerfiles/dockerfile.base_ros_x86
dpush jazzy
```

arm系のイメージを作るときはdockerfileを変える

### Third party imageを利用するとき

setupに記述
base imageからproject 用イメージ作成
third party imageをpullしてきて、パッケージ用イメージ作成
build時
image指定
dbuild image_rf_robot slam_toolbox slam_toolbox
dbuild image_rf_robot rplidar rplidar
実行時
imageを指定
DDS指定

### setupファイル例

```bash
#! /bin/bash

source $ACSL_ROS2_DIR/bashrc
echo ${PROJECT}${TARGET}${x86}
echo ${ROS_DOMAIN_ID}
ROS_DISTRO=humble # base image 指定
if [ "$1" == "full" ]; then
  dpull $ROS_DISTRO$x86
  dtag $ROS_DISTRO$x86 image_${PROJECT}${TARGET}${x86}

  dbuild $ROS_DISTRO${x86} slam_toolbox slam_toolbox # base imageをベースにパッケージ特化イメージを作成
  # docker pull microros/micro-ros-agent:jazzy # third party imageを利用する場合
  cd ~/.ssh/
  cat id_*.pub >>authorized_keys
fi

build_project megarover3_bringup megarover_description
```
