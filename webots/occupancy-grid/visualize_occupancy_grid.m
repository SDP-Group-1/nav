load('./webotsLidarReadings.mat');
load('offlineSlamData.mat');

% for movement_threshold = 0:1


maxLidarRange = 3.7;
mapResolution = 60;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

updated_threshold = 0.2;

slamAlg.LoopClosureThreshold = 400;
slamAlg.LoopClosureSearchRadius = 8;
slamAlg.MovementThreshold = [updated_threshold, updated_threshold];

for i=1:length(webots_scans)
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, webots_scans{i});
    i
end

[scans, optimizedPoses]  = scansAndPoses(slamAlg);
map = buildMap(scans, optimizedPoses, mapResolution, maxLidarRange);

figure; 
show(map);
hold on
show(slamAlg.PoseGraph, 'IDs', 'off');
hold off
title('Occupancy Grid Map Built Using Lidar SLAM', updated_threshold);