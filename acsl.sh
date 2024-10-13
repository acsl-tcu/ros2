#! /bin/bash

function initialize_project() {
  cat <<_EOT_
  Initialize acsl project
    PROJECT : $1
    ROS DOMAIN ID : $2
_EOT_
  if [ -d ./.acsl ]; then
    source ~/.bashrc
    cd .acsl/ros2/0_host_commands
  else
    echo "create .acsl folder"
    mkdir .acsl
    cd .acsl
    git clone https://github.com/acsl-tcu/ros2.git
    cd ros2/0_host_commands
  fi
  bash ./setup.sh $1 $2
  exit 1
}

case ${1} in
"init")
  if [ $# -eq 3 ]; then
    initialize_project ${@:2:($# - 1)}
  else
    echo "Usage : acsl init project_name ros_domain_id"
  fi
  ;;
"install")
  if [ $# -ge 2 ]; then
    echo "install packages : ${@:2:($# - 1)}"
  else
    echo "Usage : ascl install package_name"
  fi
  ;;
"remove")
  if [ $# -ge 2 ]; then
    echo "remove packages : ${@:2:($# - 1)}"
  else
    echo "Usage : acsl remove package_name"
  fi
  ;;
esac

# export ORGPATH="/home/sekiguchi/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/Program Files (x86)/Common Files/Oracle/Java/java8path:/mnt/c/Program Files (x86)/Common Files/Oracle/Java/javapath:/mnt/c/Program Files (x86)/Razer/ChromaBroadcast/bin:/mnt/c/Program Files/Razer/ChromaBroadcast/bin:/mnt/c/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/intel64/compiler:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program Files/NVIDIA Corporation/NVIDIA NvDLISR:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files (x86)/Wolfram Research/WolframScript/:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Program Files/MATLAB/R2024a/runtime/win64:/mnt/c/Program Files/MATLAB/R2024a/bin:/mnt/c/WINDOWS/system32/config/systemprofile/AppData/Local/Microsoft/WindowsApps:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/Program Files/Git/cmd:/mnt/c/Users/kasek/AppData/Local/Programs/Python/Python310/Scripts/:/mnt/c/Users/kasek/AppData/Local/Programs/Python/Python310/:/mnt/c/Users/kasek/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/kasek/AppData/Local/GitHubDesktop/bin:/mnt/c/Users/kasek/AppData/Local/Programs/Microsoft VS Code/bin:/mnt/c/texlive/2022/bin/win32:/mnt/c/Program Files/JetBrains/PyCharm 2024.2.2/bin:/snap/bin"
