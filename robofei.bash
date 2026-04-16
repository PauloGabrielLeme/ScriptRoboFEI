#! /usr/bin/bash

if (( EUID != 0 )); hten
  echo 'Erro: Esse script deve ser executado como root'
  echo 'Execute este script com sudo'
  echo 'sudo ./ros2.bash'
  exit 1
fi

#Instala o Python e o ROS

apt update -y && apt install locales -y
apt install python3 -y
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
apt install software-properties-common
add-apt-repository universe
apt update && apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
dpkg -i /tmp/ros2-apt-source.deb
apt update -y && apt install ros-dev-tools -y
apt update -y
apt upgrade -y
apt install ros-jazzy-desktop -y
apt install ros-jazzy-ros-base -y

# Instala o VS Code

apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg

echo 'Types: deb' >> /etc/apt/sources.list.d
echo 'URIs: https://packages.microsoft.com/repos/code' >> /etc/apt/sources.list.d
echo 'Suites: stable' >> /etc/apt/sources.list.d
echo 'Components: main' >> /etc/apt/sources.list.d
echo 'Architectures: amd64,arm64,armhf' >> /etc/apt/sources.list.d
echo 'Signed-By: /usr/share/keyrings/microsoft.gpg' >> /etc/apt/sources.list.d

apt install apt-transport-https && apt update && apt install code 
