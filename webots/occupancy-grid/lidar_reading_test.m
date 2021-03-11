load('~/Desktop/lidar_readings_for_test.mat');

maxLidarRange = 2.8;
mapResolution = 20;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

slamAlg.LoopClosureThreshold = 210;
slamAlg.LoopClosureSearchRadius = 10;

    figure;
for i=1:50
 
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, lidar_scans{i});
    
    if isScanAccepted
        fprintf('Added scan %d \n', i);
    end
    show(slamAlg, 'Poses', 'off');
   hold on;
   show(slamAlg.PoseGraph);
   drawnow
end

% [scans, optimizedPoses] = scansAndPoses(slamAlg);
% map = buildMap(lidar_scans, optimizedPoses, mapResolution, maxLidarRange);
% 
% figure; 
% show(map);
% hold on
% show(slamAlg.PoseGraph, 'IDs', 'off');
% hold off

[updatedPose,stat] = optimizePoseGraph(slamAlg.PoseGraph);
figure;
show(updatedPose);
title('Pose graph opt');

referenceScan = lidar_scans{1,16}
currentScan = lidar_scans{1,40} 
currScanCart = currentScan.Cartesian;
refScanCart = referenceScan.Cartesian;
class(referenceScan)
figure
plot(refScanCart(:,1),refScanCart(:,2),'k.');
hold on
plot(currScanCart(:,1),currScanCart(:,2),'r.');
legend('Reference laser scan','Current laser scan','Location','NorthWest');
transform = matchScans(currentScan,referenceScan)

transScan = transformScan(currentScan,transform)
figure
plot(refScanCart(:,1),refScanCart(:,2),'k.');
hold on
transScanCart = transScan.Cartesian;
plot(transScanCart(:,1),transScanCart(:,2),'r.')
legend('Reference laser scan','Transformed current laser scan','Location','NorthWest');

