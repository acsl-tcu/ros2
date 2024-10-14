#! /usr/bin/bash +x

ACSL_ROS2_DIR=$(
  cd $(dirname $0)
  cd ../
  pwd
)
# ros node (＝　コンテナ)　の立ち上げ
if [ $# -ge 1 ]; then
  PROJECT=$1
  sudo chmod -R a+x $ACSL_ROS2_DIR/1_docker/common/

  $ACSL_ROS2_DIR/0_host_commands/setup_bashrc $@
  $ACSL_ROS2_DIR/0_host_commands/setup_udev $ACSL_ROS2_DIR/1_docker/common/rules/$PROJECT.rules
  $ACSL_ROS2_DIR/0_host_commands/setup_systemd $ACSL_ROS2_DIR/0_host_commands/project_launch_sh
  bash # source .bashrc忘れの予防
else
  source $ACSL_ROS2_DIR/1_docker/common/scripts/super_echo
  recho "Require PROJECT name"
fi
