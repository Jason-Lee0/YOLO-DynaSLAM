# YOLO Dynamic ORB_SLAM 
## (ROS Wrapper by ntut108318099)
(from: https://github.com/bijustin/YOLO-DynaSLAM/issues/3 )

YOLO Dynamic ORB_SLAM is a visual SLAM system that is robust in dynamic scenarios for RGB-D configuration.
See our other repository for related work: https://github.com/bijustin/Fast-Dynamic-ORB-SLAM/
Our paper is located here: https://github.com/bijustin/YOLO-DynaSLAM/blob/master/dynamic-orb-slam.pdf

We provide one example to run the SLAM system in the [TUM dataset](http://projects.asl.ethz.ch/datasets/doku.php?id=kmavvisualinertialdatasets) as RGB-D.

Example result (left are without dynamic object detection or masks, right are with YOLOv3 and masks), run on [rgbd_dataset_freiburg3_walking_xyz](https://vision.in.tum.de/data/datasets/rgbd-dataset/download):

<img src="https://github.com/bijustin/Flow-DynaSLAM/blob/master/imgs/Dyna_NOyolo.png" width="320" height="240"> <img src="https://github.com/bijustin/Flow-DynaSLAM/blob/master/imgs/Dyna_yolo.png" width="320" height="240">

<img src="https://github.com/bijustin/Flow-DynaSLAM/blob/master/imgs/SLAM_NOyolo.png" width="320" height="240"> <img src="https://github.com/bijustin/Flow-DynaSLAM/blob/master/imgs/SLAM_yolo.png" width="320" height="240">

## Getting Started
- Install ORB-SLAM2 prerequisites: C++11 or C++0x Compiler, Pangolin, OpenCV and Eigen3  (https://github.com/raulmur/ORB_SLAM2).
- Install boost libraries with the command `sudo apt-get install libboost-all-dev`.
- Install python 2.7, keras and tensorflow, and download the `yolov3.weights` model from this address: https://pjreddie.com/media/files/yolov3.weights. 
- Clone this repo:
```bash
git clone https://github.com/bijustin/YOLO-DynaSLAM.git
cd YOLO-DynaSLAM
```
```
cd YOLO-DynaSLAM
chmod +x build.sh
./build.sh
```
- Place the `yolov3.weights` model in the folder `YOLO-DynaSLAM/src/yolo/`.

## RGB-D Example on TUM Dataset
- Download a sequence from http://vision.in.tum.de/data/datasets/rgbd-dataset/download and uncompress it.

- Associate RGB images and depth images executing the python script [associate.py](http://vision.in.tum.de/data/datasets/rgbd-dataset/tools):

  ```
  python associate.py PATH_TO_SEQUENCE/rgb.txt PATH_TO_SEQUENCE/depth.txt > associations.txt
  ```
These associations files are given in the folder `./Examples/RGB-D/associations/` for the TUM dynamic sequences.

- Execute the following command. Change `TUMX.yaml` to TUM1.yaml,TUM2.yaml or TUM3.yaml for freiburg1, freiburg2 and freiburg3 sequences respectively. Change `PATH_TO_SEQUENCE_FOLDER` to the uncompressed sequence folder. Change `ASSOCIATIONS_FILE` to the path to the corresponding associations file. `YOLO`is an optional parameter.

  ```
  ./Examples/RGB-D/rgbd_tum_yolo Vocabulary/ORBvoc.txt Examples/RGB-D/TUMX.yaml PATH_TO_SEQUENCE_FOLDER ASSOCIATIONS_FILE (YOLO)
  ```
  
If `YOLO` is **not** provided, only the geometrical approach is used to detect dynamic objects. 

If `YOLO` is provided, Yolov3 is used to segment the potential dynamic content of every frame. 

## Acknowledgements
Our code builds on [ORB-SLAM2](https://github.com/raulmur/ORB_SLAM2) and [DynaSLAM](https://github.com/BertaBescos/DynaSLAM).

# YOLO Dynamic ORB_SLAM

# YOLO_Dynamic_ROS (by ntut108318099)
1. Be sure YOLO-DynaSLAM could run.
2. Add the path including *Examples/ROS/YOLO_DynaSLAM* to the ROS_PACKAGE_PATH environment variable. Open .bashrc file and add at the end the following line. Replace PATH by the folder where you cloned YOLO-DynaSLAM:

  ```
  export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:PATH/YOLO-DynaSLAM/Examples/ROS
  ```
  
3. Execute `build_ros.sh` script:

  ```
  chmod +x build_ros.sh
  ./build_ros.sh
  ```

**Only release code for RGB-D camera. If you need the code with the other diveces,you could ask me or refer the ros-rgbd.cc to modify.**

*BTW,I ran the code with opencv3.4.4,and it worked.
If you used other version of opencv,you need to change the line in CMakeLists.*

# Run ROS-rgbd node:

For an RGB-D input from topics `/camera/rgb/image_raw` and `/camera/depth_registered/image_raw`, run node ORB_SLAM2/RGBD. You will need to provide the vocabulary file and a settings file. See the RGB-D example above.

  ```
  rosrun YOLO_DynaSLAM RGBD PATH_TO_VOCABULARY PATH_TO_SETTINGS_FILE
  ```
**It need to run the command at your <YOLO_DynaSLAM> folder,or it will fail to detect yolov3.cfg and yolov3.weight.**

**(To avoid it ,you could change the line 23,24 of yolo.cc)**

# Suggestion:

## If you want to use another image topic: 
    when you change the subscribe topics, you must rebuild the code (./build_ros.sh).
    
## Run TUM-Dataset rosbag no result: 
    You can change the TUM*.yaml you called. Change the  `DepthMapFactor` value to  `1.0` . 

