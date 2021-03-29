load('path.mat');
load('occupancy_grid.mat');

show(map);
hold on
plot(path.States(:,1), path.States(:,2), 'r-', 'LineWidth', 2)