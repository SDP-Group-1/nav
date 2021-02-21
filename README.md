# Overview
- No-one is able to set up ros and webots so instead, we have looked for alternatives.
- One alternative found is MATLAB

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

# How to run
1. Connect to Dice remotely using Remote Desktop
	- [Mac](http://computing.help.inf.ed.ac.uk/RDPonMac) 
	- [Windows](http://computing.help.inf.ed.ac.uk/RDPonWindows)
	- [Other](http://computing.help.inf.ed.ac.uk/remote-desktop). Look at "How to get started with remote desktop" section.
2. Open Terminal within the Remote Desktop and run
	- `ssh s18*****.lab.inf.ed.ac.uk`
	-  `matlab`
3. MATLAB will now open and you can follow along the above examples.

# Expected Result from Combining Examples Above

![foo](images/rootREADme/Pose%20Graph.png)

![First Loop Closure](images/rootREADme/First%20Loop%20Closure.png)

![Final Built Map](images/rootREADme/Final%20Built%20Map.png)

![Occupancy Grid with planned route](images/rootREADme/Occupancy%20Grid.png)

# TODO:
1. Create simulations
	- Haven't explored all that MATLAB has to offer in this respect so maybe there is something they provide something for this?
	- Otherwise the provided examples above show how we can create 2d visualisations.
2. The above examples use Lidar, our robot doesn't use Lidar... 
	- Can we use Lidar? 
	- Maybe we can change from Lidar to something else and still use the above toolboxes?
3. Add to this list as you see fit.
