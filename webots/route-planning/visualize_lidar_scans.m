load('./webotsLidarReadings.mat');

maxLidarRange = 3;
mapResolution = 20;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

slamAlg.LoopClosureThreshold = 1000;  
slamAlg.LoopClosureSearchRadius = 1000;

figure;
for i=1:length(webots_scans)
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, webots_scans{i});
    if isScanAccepted
        fprintf('Added scan %d \n', i);
        show(slamAlg, 'Poses', 'off');
        hold on;
        show(slamAlg.PoseGraph);
        hold off;
        drawnow
    end
end

show(slamAlg);
title({'Map of the Environment','Pose Graph for the Lidar Scans'});