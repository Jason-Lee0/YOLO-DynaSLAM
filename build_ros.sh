echo "Building ROS nodes"

cd Examples/ROS/YOLO_DynaSLAM
mkdir build
cd build
cmake .. -DROS_BUILD_TYPE=Release
make -j
