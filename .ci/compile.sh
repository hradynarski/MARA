#!/bin/bash

set -e

rm -rf src/mara/* #Remove downloaded MARA to build current Branch
cp -r /tmp/MARA/* src/mara
#unset ROS_DISTRO
source /opt/ros/$ROS2_DISTRO/setup.bash
colcon build --merge-install --packages-skip individual_trajectories_bridge
# Build ROS-ROS 2.0 Bridge
source /opt/ros/$ROS_DISTRO/setup.bash
colcon build --merge-install --packages-select individual_trajectories_bridge
sed -i 's#/opt/ros/melodic#/opt/ros/crystal#g' /root/ros2_mara_ws/install/setup.bash
echo "Build MARA_ROS1"
#Build ROS workspace
source /root/ros2_mara_ws/install/setup.bash
source /opt/ros/$ROS_DISTRO/setup.bash
mkdir -p /root/catkin_mara_ws/src
cd /root/catkin_mara_ws/src
git clone https://github.com/AcutronicRobotics/MARA_ROS1
cd ..
catkin_make_isolated --install
