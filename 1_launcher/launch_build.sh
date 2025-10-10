#!/usr/bin/bash
source /root/.venv/bin/activate
source /common/scripts/super_echo
gecho "LAUNCH BUILD: ${ROS_DOMAIN_ID}"
cd /root/ros2_ws
source /opt/ros/$ROS_DISTRO/setup.bash
which colcon
colcon --version
ls -l /usr/bin/colcon
/usr/bin/colcon --version
if [ $# -ge 1 ]; then
  echo " colcon build --symlink-install --packages-select $@ --parallel-workers $(($(nproc) - 1))"
/usr/bin/colcon build --symlink-install --packages-select $@ --parallel-workers $(($(nproc) - 1))
else
  echo " colcon build --symlink-install --parallel-workers $(($(nproc) - 1))"
colcon build --symlink-install --parallel-workers $(($(nproc) - 1))
fi
source install/setup.bash
