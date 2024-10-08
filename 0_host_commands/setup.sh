#! /usr/bin/bash +x

# ros node (＝　コンテナ)　の立ち上げ
if [ $# -eq 1 ]; then
  export PROJECT=$1
  chmod -R a+x /home/$USER/acsl_ros2/1_docker/common/scripts
  export PATH=$PATH:/home/$USER/acsl_ros2/1_docker/common/scripts
  source ~/acsl_ros2/1_docker/common/scripts/super_echo
  set_bashrc "source ~/acsl_ros2/1_docker/common/scripts/super_echo"
  set_bashrc "export PATH" "$PATH:/home/$USER/acsl_ros2/1_docker/common/scripts:/home/$USER/acsl_ros2/0_host_commands/scripts"
  set_bashrc "alias home" "'source home.sh'"
  set_bashrc "export PROJECT" $PROJECT

  echo "Do following command"
  gecho "source ~/.bashrc"

  # [udev] generate custom.rules
  sudo rm -f /etc/udev/rules.d/90-custom.rules
  cd ~/acsl_ros2/1_docker/common/rules
  if [[ -n $(ls | grep ${PROJECT}.rules) ]]; then
    sudo cp -p ${PROJECT}.rules /etc/udev/rules.d/90-custom.rules
  else
    sudo cp -p default.rules /etc/udev/rules.d/90-custom.rules
  fi
  sudo udevadm control --reload-rules
  sudo udevadm trigger

  # [systemd] generate project_launch.service and project_launch.sh
  cd ~/acsl_ros2/0_host_commands
  # 注意：systemd は rootで実行されるので ~ が使えないため、sedでフルパスを指定
  sed -e "s|/homedir|$HOME|g" project_launch_service >project_launch.service

  echo "project_launch_${PROJECT}_sh"
  sed -e "s|/homedir|$HOME|g" project_launcher/project_launch_${PROJECT}_sh >project_launch.sh

  # Setting systemd
  sudo chmod a+x project_launch.sh
  sudo chmod a+x project_launch.service
  sudo chmod -R a+x ~/acsl_ros2/1_docker/common/
  sudo rm /etc/systemd/system/project_launch.service
  sudo mv project_launch.service /etc/systemd/system
  sudo systemctl daemon-reload
  sudo systemctl enable project_launch
  sudo systemctl start project_launch

# sudo systemctl stop project_launch
else
  source ~/acsl_ros2/1_docker/common/scripts/super_echo
  recho "Require PROJECT name"
fi
