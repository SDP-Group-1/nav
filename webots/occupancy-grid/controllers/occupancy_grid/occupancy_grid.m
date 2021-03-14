% MATLAB controller for Webots
% File:          basic_movement.m


TIME_STEP = 2000;

LEFT_BASE_SPEED = 3;
RIGHT_BASE_SPEED = 3;

% set up supervisor
robot_node = wb_supervisor_node_get_self();

if robot_node == 0
  wb_console_print('No DEF MY_ROBOT node found in the current world file', WB_STDERR);
  quit(1);
end

trans_field = wb_supervisor_node_get_field(robot_node, 'translation');

% get the motor devices
left_motor = wb_robot_get_device('left wheel motor');
right_motor = wb_robot_get_device('right wheel motor');

% set the target position of the motors
wb_motor_set_position(left_motor, Inf);
wb_motor_set_position(right_motor, Inf);

% set up the motor speeds at 10% of the MAX_SPEED.
wb_motor_set_velocity(left_motor, LEFT_BASE_SPEED);
wb_motor_set_velocity(right_motor, RIGHT_BASE_SPEED);

% get and initialise the lidar device
lidar = wb_robot_get_device('LDS-01');
wb_lidar_enable(lidar, TIME_STEP);
wb_lidar_enable_point_cloud(lidar);

num_scans = 10;
webots_scans = lidarScan.empty(num_scans,0);
scan_index = 1;

while wb_robot_step(TIME_STEP) ~= -1

  wb_motor_set_velocity(left_motor, LEFT_BASE_SPEED);
  wb_motor_set_velocity(right_motor, RIGHT_BASE_SPEED);
  
  values = wb_supervisor_field_get_sf_vec3f(trans_field);
  wb_console_print(sprintf('MY_ROBOT is at position: %g %g %g\n', values(1), values(2), values(3)), WB_STDOUT);
  num_points = wb_lidar_get_number_of_points(lidar);
  point_cloud = wb_lidar_get_point_cloud(lidar);
  
  
  coordinates = zeros(num_points, 2);
  for i = 1:num_points
    coordinates(i, 1) = point_cloud(i).z;
    coordinates(i, 2) = point_cloud(i).x;
  end
  lidar_scan = lidarScan(coordinates);
  webots_scans{scan_index} = lidar_scan;
    
  if scan_index == num_scans
    save('../../webotsLidarReadings.mat', 'webots_scans')
    return
  end
  scan_index = scan_index + 1;
  
end



% cleanup code goes here: write data to files, etc.
