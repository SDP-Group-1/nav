% MATLAB controller for Webots
% File:          basic_movement.m


TIME_STEP = 200;

LEFT_BASE_SPEED = 5;
RIGHT_BASE_SPEED = 1;

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

num_scans = 50;
lidar_scans = lidarScan.empty(num_scans,0);
scan_index = 1;

while wb_robot_step(TIME_STEP) ~= -1

  wb_motor_set_velocity(left_motor, LEFT_BASE_SPEED);
  wb_motor_set_velocity(right_motor, RIGHT_BASE_SPEED);
  
  num_points = wb_lidar_get_number_of_points(lidar);
  point_cloud = wb_lidar_get_point_cloud(lidar);
  coordinates = zeros(num_points, 2);
  for i = 1:num_points
    coordinates(i, 1) = point_cloud(i).z;
    coordinates(i, 2) = point_cloud(i).x;
  end
  lidar_scan = lidarScan(coordinates);
  lidar_scans{scan_index} = lidar_scan;
  
  if scan_index == num_scans
    save('~/Desktop/lidar_readings_for_test.mat', 'lidar_scans')
    return
  end
  scan_index = scan_index + 1;
  
end



% cleanup code goes here: write data to files, etc.
