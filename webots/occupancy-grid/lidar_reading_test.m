load('~/Desktop/lidar_readings_for_test.mat');
load('offlineSlamData.mat');

maxLidarRange = 3;
mapResolution = 20;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

slamAlg.LoopClosureThreshold = 360;
slamAlg.LoopClosureSearchRadius = 3;
firstTimeLCDetected = false;

figure;
for i=1:length(lidar_scans)
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, lidar_scans{i});
    if ~isScanAccepted
        continue;
    end
end
title('First loop closure');

[scans, optimizedPoses]  = scansAndPoses(slamAlg);
map = buildMap(scans, optimizedPoses, mapResolution, maxLidarRange);

figure; 
show(map);
hold on
show(slamAlg.PoseGraph, 'IDs', 'off');
hold off
title('Occupancy Grid Map Built Using Lidar SLAM');