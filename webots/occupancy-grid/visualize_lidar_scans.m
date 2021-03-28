load('webotsLidarReadings.mat');
load('offlineSlamData.mat');

maxLidarRange = 3.7;
mapResolution = 20;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

updated_threshold = 0.15;

slamAlg.LoopClosureThreshold = 210;
slamAlg.LoopClosureSearchRadius = 3;
slamAlg.MovementThreshold = [updated_threshold, updated_threshold];

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