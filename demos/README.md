# Overview

There are two sets of demos
- SLAM
- Motion Planning

Both demos use pre-built lidar scans. These demos show how our system can interpret these lidar scans.

### A brief explanation of the system

Our system uses lidar sensor readings to build a map of the robot's environment and localises the robot within it. 
As the robot moves, lidar readings are recieved and interpreted. The readings are interpreted by a SLAM algorithm. The SLAM algorithm builds a map of the environment. 

Furthermore, we then can choose a point within the map and plan a route using the rapidly-exploring random tree (RRT) algorithm (a type of path finding algorithm). 

# SLAM Demos
There are 4 demostrations within the slam folder. Each builds on each other.
1. tenScansDEMO.m
    1. Reconstructs the scene by plotting the lidar scans and poses tracked by the slamAlg.
2. firstLoopClosureDEMO.m
    1. Plots the lidar scans and poses when the first loop closure is identified. This plot shows overlaid scans and an optimized pose graph for the first loop closure. A loop closure edge is added as a red link.
3. buildMapDEMO.m
    1. Plots the final built map after all scans are added to the slamAlg object.
4. buildOccupancyGrid.m
    1. Visualizes the occupancy grid map populated with the lidar scans and the optimized pose graph.
    2. The optimized scans and poses can be used to generate a occupancyMap, which represents the environment as a probabilistic occupancy grid.

[Reference](https://www.mathworks.com/help/nav/ug/implement-simultaneous-localization-and-mapping-with-lidar-scans.html)

# Motion Planning Demos
There is currently 1 demonstration within the motion planning folder.
1. planRouteDEMO.m
    1. Visualises the RRT algorithm.
    2. The RRT algorithm plans a route between two points within a occupancy grid.
 
[Reference](https://www.mathworks.com/help/nav/ug/plan-mobile-robot-paths-using-rrt.html)

# How To Run
1. Clone this repository into your folder
```bash
git clone https://github.com/SDP-Group-1/nav.git
```
2. Open MATLAB. Instructions on how to use MATLAB on DICE are on the front page.
3. Open and run a demo file (filenames containing 'DEMO').
