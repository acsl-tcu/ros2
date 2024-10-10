#! /usr/bin/bash +x

# ros node (＝　コンテナ)　の立ち上げ
if [ $# -ge 1 ]; then
  export PROJECT=$1
  chmod -R a+x /home/$USER/ros2/0_host_commands/scripts
  chmod -R a+x /home/$USER/ros2/1_docker/common/scripts
  if [[ -z $(cat ~/.bashrc | grep ORGPATH) ]]; then
    set_bashrc "export ORGPATH" $PATH
  else
    PATH=$ORGPATH
  fi
  export PATH=$PATH:/home/$USER/ros2/1_docker/common/scripts:/home/$USER/ros2/0_host_commands/scripts
  source ~/ros2/1_docker/common/scripts/super_echo
  set_bashrc "source ~/ros2/1_docker/common/scripts/super_echo"
  set_bashrc "export PATH" $PATH
  set_bashrc "alias home" "'source home.sh'"
  set_bashrc "export PROJECT" $PROJECT
  if [ $# -eq 2 ]; then
    RID=$2
  else
    RID=$(cat /home/$USER/ros2/0_host_commands/project_launcher/ros2_id_list | grep $PROJECT | awk '{print $NF}')
  fi
  set_bashrc "export ROS_DOMAIN_ID" $RID

  echo "Do following command"
  gecho "source ~/.bashrc"

  # [udev] generate custom.rules
  sudo rm -f /etc/udev/rules.d/90-custom.rules
  cd ~/ros2/1_docker/common/rules
  if [[ -n $(ls | grep ${PROJECT}.rules) ]]; then
    sudo cp -p ${PROJECT}.rules /etc/udev/rules.d/90-custom.rules
  else
    sudo cp -p default.rules /etc/udev/rules.d/90-custom.rules
  fi
  sudo udevadm control --reload-rules
  sudo udevadm trigger

  # [systemd] generate project_launch.service and project_launch.sh
  cd ~/ros2/0_host_commands
  # 注意：systemd は rootで実行されるので ~ が使えないため、sedでフルパスを指定
  sed -e "s|/homedir|$HOME|g" project_launch_service >project_launch.service

  echo "project_launch_${PROJECT}_sh"
  sed -e "s|/homedir|$HOME|g" project_launcher/project_launch_${PROJECT}_sh >project_launch.sh

  # Setting systemd
  sudo chmod a+x project_launch.sh
  sudo chmod a+x project_launch.service
  sudo chmod -R a+x ~/ros2/1_docker/common/
  sudo rm /etc/systemd/system/project_launch.service
  sudo mv project_launch.service /etc/systemd/system
  sudo systemctl daemon-reload
  sudo systemctl enable project_launch
  sudo systemctl start project_launch

# sudo systemctl stop project_launch
else
  source ~/ros2/1_docker/common/scripts/super_echo
  recho "Require PROJECT name"
fi
