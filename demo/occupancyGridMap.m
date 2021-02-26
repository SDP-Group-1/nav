% Load a down-sampled data set consisting of laser scans collected from 
% a mobile robot in an indoor environment. The average displacement 
% between every two scans is around 0.6 meters. The offlineSlamData.mat 
% file contains the scans variable
% TODO: get our own data from webots, use for testing.
load('offlineSlamData.mat');


% Create a lidarSLAM object and set the map resolution and the max lidar 
% range. This example uses a Jackal™ robot from Clearpath Robotics™. The 
% robot is equipped with a SICK™ TiM-511 laser scanner with a max range 
% of 10 meters. Set the max lidar range slightly smaller than the max 
% scan range (8m), as the laser readings are less accurate near max 
% range. Set the grid map resolution to 20 cells per meter, which gives 
% a 5cm precision.
% TODO: change from Jackal robot to something we can use in webots 
% and something we can actually afford? Maybe we can build our software
% and make it so it generalised to any robot we use that has radar?
% We would just have to calibrate lidar readings differently? Look into 
% this.
maxLidarRange = 8;
mapResolution = 20;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

% The following loop closure parameters are set empirically. Using higher
% loop closure threshold helps reject false positives in loop closure 
% identification process.
slamAlg.LoopClosureThreshold = 210;  
slamAlg.LoopClosureSearchRadius = 8;

% Observe the Effect of Loop Closures and the Optimization Process
% Continue to add scans in a loop. Loop closures should be automatically 
% detected as the robot moves. Pose graph optimization is performed 
% whenever a loop closure is identified. The output optimizationInfo has
% a field, IsPerformed, that indicates when pose graph optimization 
% occurs..

% Plot the scans and poses whenever a loop closure is identified and 
% verify the results visually. This plot shows overlaid scans and an 
% optimized pose graph for the first loop closure. A loop closure edge is 
% added as a red link.
firstTimeLCDetected = false;

for i=0:length(scans)
    addScan(slamAlg, scans{i});
end

% The optimized scans and poses can be used to generate a occupancyMap, 
% which represents the environment as a probabilistic occupancy grid.
[scans, optimizedPoses]  = scansAndPoses(slamAlg);
map = buildMap(scans, optimizedPoses, mapResolution, maxLidarRange);

% Visualize the occupancy grid map populated with the laser scans and the 
% optimized pose graph.
figure; 
show(map);
hold on
show(slamAlg.PoseGraph, 'IDs', 'off');
hold off
title('Occupancy Grid Map Built Using Lidar SLAM');