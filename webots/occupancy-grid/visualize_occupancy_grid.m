load('./webotsLidarReadings.mat');
load('offlineSlamData.mat');

% for movement_threshold = 0:1


maxLidarRange = 3.7;
mapResolution = 20;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

updated_threshold = 0.15;

slamAlg.LoopClosureThreshold = 210;
slamAlg.LoopClosureSearchRadius = 3;
slamAlg.MovementThreshold = [updated_threshold, updated_threshold];

for i=1:length(webots_scans)
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, webots_scans{i});
%     if ~isScanAccepted
%         continue;
%     end
    if mod(i, 2000) == 0
        
        [scans, optimizedPoses]  = scansAndPoses(slamAlg);
        map = buildMap(scans, optimizedPoses, mapResolution, maxLidarRange);
        
        map_file_name = append('./map', string(i));
        map_file_name = append(map_file_name, '.mat');
        save(map_file_name, 'map');
        
        slamAlg_file_name = append('./slamAlg', string(i));
        slamAlg_file_name = append(slamAlg_file_name, '.mat');
        save(slamAlg_file_name, 'slamAlg');
        
        figure; 
        show(map);
        hold on
        show(slamAlg.PoseGraph, 'IDs', 'off');
        hold off
    end
    i
end

[scans, optimizedPoses]  = scansAndPoses(slamAlg);
map = buildMap(scans, optimizedPoses, mapResolution, maxLidarRange);

save('./map.mat', 'map');
save('./slamAlg.mat', 'slamAlg');

figure; 
show(map);
hold on
show(slamAlg.PoseGraph, 'IDs', 'off');
hold off
title('Occupancy Grid Map Built Using Lidar SLAM', updated_threshold);