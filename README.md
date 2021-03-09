# MATLAB Libaries

- [Lidar toolbox](https://www.mathworks.com/help/lidar/index.html?searchHighlight=lidar&s_tid=srchtitle)
	- can use this to interpret data from Lidar sensors for navigation
- [Navigation toolbox](https://www.mathworks.com/help/nav/index.html "s")
	- [slam](https://www.mathworks.com/help/nav/slam.html)
		- [example implementation](https://www.mathworks.com/help/nav/ug/implement-simultaneous-localization-and-mapping-with-lidar-scans.html)
	- [Motion Planning](https://www.mathworks.com/help/nav/motion-planning.html)
		- [example implementation](https://www.mathworks.com/help/nav/ug/plan-mobile-robot-paths-using-rrt.html)

# MATLAB and Webots on DICE
You are not able to run these together on Dice due to the fact that you have to ssh into lab to use MATLAB and webots is on another path. You may try to do this but I encountered many errors related to MATLAB not being on the same path as webots. I tried adding to the path using PATH=$PATH but it still didn't work.

Instead, download webots and matlab on your personal computer or in a virtual machine.

A guide on how to set up MATLAB and Webots can be found at [here](https://cyberbotics.com/doc/guide/using-matlab).
To get familiar with webots and MATLAB if you haven't already, I suggest to follow along this [10 min guide](https://cyberbotics.com/doc/guide/tutorial-1-your-first-simulation-in-webots?tab-language=matlab#create-a-new-world).

# Robot
Chosen robot: [TurtleBot3Burger](https://cyberbotics.com/doc/guide/turtlebot3-burger).

Import the robot into your world and it comes along with a [LDS-01](https://cyberbotics.com/doc/guide/lidar-sensors#robotis-lds-01) lidar sensor.

For an example of the robot set-up, look at the basic-example folder within the webots folder in this repository.

# Basic Robot Movement
To move the robot, you must create a controller. For a very basic example of a controller, look at the controller within the basic-example within the webots folder in this repository.

Essentially, we create a loop and at every time-step, we update the velocity of the left and right wheel motor. If we want the turtlebot to move left, we can increase the velocity of the right wheel motor.

For more detail on velocity control, see [here](https://cyberbotics.com/doc/reference/motor#motor-functions).

# Lidar Readings 

Just like for basic movement, the lidar must be controlled within a controller. For a basic example, please see the lidar-readings webots project located within the webots folder.

At every time stop, we read the lidar readings. The lidar readings are represented as a an array of points corresponding to the distance to the object being measured at that angle.

For more detail about the lidar, see [here](https://cyberbotics.com/doc/reference/lidar?tab-language=matlab#wb_lidar_enable).
