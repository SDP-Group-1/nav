occGrid = load("occupancyGrid.mat", "map").map;
% load("office_area_gridmap.mat", "occGrid")
show(occGrid)
% Set the start and goal poses
start = [-7.5, -2.5, -pi];
goal = [7.5, -2, 0];


% Show the start and goal positions of the robot
hold on
plot(start(1), start(2), 'ro')
plot(goal(1), goal(2), 'mo')

% Show the start and goal headings
r = 0.5;
plot([start(1), start(1) + r*cos(start(3))], [start(2), start(2) + r*sin(start(3))], 'r-' )
plot([goal(1), goal(1) + r*cos(goal(3))], [goal(2), goal(2) + r*sin(goal(3))], 'm-' )
hold off
