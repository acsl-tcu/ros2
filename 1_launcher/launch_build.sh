#!/usr/bin/bash

# Check if /usr/bin/bash exists
# if [ -x "/usr/bin/bash" ]; then
#   exec /usr/bin/bash "$@"
# # Check if /bin/bash exists
# elif [ -x "/bin/bash" ]; then
#   exec /bin/bash "$@"
# else
#   echo "Bash not found in /usr/bin/bash or /bin/bash"
#   exit 1
# fi

source /common/scripts/super_echo
becho "colcon build" $@
cd /root/ros2_ws
source /opt/ros/$ROS_DISTRO/setup.bash
if [ $# -ge 1 ]; then
  colcon build --symlink-install --packages-select $@ --parallel-workers $(($(nproc) - 1))
else
  colcon build --symlink-install --parallel-workers $(($(nproc) - 1))
fi
source install/setup.bash
