# MATLAB

- [Lidar toolbox](https://www.mathworks.com/help/lidar/index.html?searchHighlight=lidar&s_tid=srchtitle)
	- can use this to interpret data from Lidar sensors for navigation
- [Navigation toolbox](https://www.mathworks.com/help/nav/index.html "s")
	- [slam](https://www.mathworks.com/help/nav/slam.html)
		- [example implementation](https://www.mathworks.com/help/nav/ug/implement-simultaneous-localization-and-mapping-with-lidar-scans.html)
	- [Motion Planning](https://www.mathworks.com/help/nav/motion-planning.html)
		- [example implementation](https://www.mathworks.com/help/nav/ug/plan-mobile-robot-paths-using-rrt.html)

With the above software we are able to:
1. Interpret Lidar Sensor Data
2. Build SLAM with Lidar Sensor Data
3. Plan a route between two points using SLAM

# How to run MATLAB on DICE
1. Connect to Dice remotely using Remote Desktop
	- [Mac](http://computing.help.inf.ed.ac.uk/RDPonMac) 
	- [Windows](http://computing.help.inf.ed.ac.uk/RDPonWindows)
	- [Other](http://computing.help.inf.ed.ac.uk/remote-desktop). Look at "How to get started with remote desktop" section.
2. Open Terminal within the Remote Desktop and run
	- `ssh s18*****.lab.inf.ed.ac.uk`
	-  `matlab`
3. MATLAB will now open

# Demos
See /demos/README.md

# Potential next steps
1. Create end to end system
2. Incorporate webots to create simulations
3. The above examples use Lidar, our robot doesn't use Lidar... 
	- Can we use Lidar? 
	- Maybe we can change from Lidar to something else and still use the above toolboxes?
5. Incorporate actual motion by using a robot using an example from [matlab](https://uk.mathworks.com/help/robotics/ug/path-following-for-differential-drive-robot.html)
6. Add to this list as you see fit.
