load('~/Desktop/lidar_readings_for_test.mat');

maxLidarRange = 2.8;
mapResolution = 20;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

slamAlg.LoopClosureThreshold = 210;
slamAlg.LoopClosureSearchRadius = 10;

for i=1:50
 
    figure;
%     plot(lidar_scans{i});
    show(slamAlg);
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, lidar_scans{i});
    
    if isScanAccepted
        fprintf('Added scan %d \n', i);
    end
end

figure;
show(slamAlg);
title({'Map of the Environment','Pose Graph for Initial 10 Scans'});