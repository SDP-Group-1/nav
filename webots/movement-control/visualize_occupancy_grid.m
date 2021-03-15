load('./webotsLidarReadings.mat');
load('offlineSlamData.mat');

maxLidarRange = 3;
mapResolution = 60;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

slamAlg.LoopClosureThreshold = 2000;
slamAlg.LoopClosureSearchRadius = 200;
firstTimeLCDetected = false;

for i=1:length(webots_scans)
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, webots_scans{i});
    if ~isScanAccepted
        continue;
    end
end
title('First loop closure');

[scans, optimizedPoses]  = scansAndPoses(slamAlg);
webotsGrid = buildMap(scans, optimizedPoses, mapResolution, maxLidarRange);

save('./occupancyGrid.mat', 'webotsGrid')

figure; 
show(webotsGrid);
hold on
show(slamAlg.PoseGraph, 'IDs', 'off');
hold off
title('Occupancy Grid Map Built Using Lidar SLAM');