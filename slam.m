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

% Observe the Map Building Process with Initial 10 Scans
% Incrementally add scans to the slamAlg object. Scan numbers are 
% printed if added to the map. The object rejects scans if the distance 
% between scans is too small. Add the first 10 scans first to test your 
% algorithm.
for i=1:10
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, scans{i});
    if isScanAccepted
        fprintf('Added scan %d \n', i);
    end
end

% Reconstruct the scene by plotting the scans and poses tracked by the slamAlg.
figure;
show(slamAlg);
title({'Map of the Environment','Pose Graph for Initial 10 Scans'});
