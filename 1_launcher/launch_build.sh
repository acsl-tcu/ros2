#!/usr/bin/bash
source /root/.venv/bin/activate
source /common/scripts/super_echo
gecho "LAUNCH BUILD: ${ROS_DOMAIN_ID}"
cd /root/ros2_ws
source /opt/ros/$ROS_DISTRO/setup.bash
if [ $# -ge 1 ]; then
  echo " python -m colcon build --symlink-install --packages-select $@ --parallel-workers $(($(nproc) - 1))"
  python -m colcon build --symlink-install --packages-select $@ --parallel-workers $(($(nproc) - 1))
else
  echo " python -m colcon build --symlink-install --parallel-workers $(($(nproc) - 1))"
  python -m colcon build --symlink-install --parallel-workers $(($(nproc) - 1))
fi
source install/setup.bash
