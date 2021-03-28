% MATLAB controller for Webots


TIME_STEP = 100;

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
wb_motor_set_velocity(left_motor, 0);
wb_motor_set_velocity(right_motor, 0);

% get and initialise the lidar device
% lidar = wb_robot_get_device('LDS-01');
lidar = wb_robot_get_device('Hokuyo URG-04LX');

wb_lidar_enable(lidar, TIME_STEP);
wb_lidar_enable_point_cloud(lidar);
min_range = wb_lidar_get_min_range(lidar);
max_range = wb_lidar_get_max_range(lidar);

num_scans = 40000;
webots_scans = lidarScan.empty(num_scans,0);
scan_index = 1;

while wb_robot_step(TIME_STEP) ~= -1

  wb_console_print(sprintf('scan_index: %g', scan_index), WB_STDOUT);

  left_speed  = LEFT_BASE_SPEED;
  right_speed = RIGHT_BASE_SPEED;

  point_cloud = wb_lidar_get_point_cloud(lidar);
  % 180 is forward, 90 is left, goes clockwise
  range_image = wb_lidar_get_range_image(lidar);
  res = wb_lidar_get_horizontal_resolution(lidar);
  
  nr_scans = 277;
  right_scans = zeros(nr_scans);
  left_scans = zeros(nr_scans);
  
  for i = 1:nr_scans
    right_scans(i) = range_image(floor(res/2) + i);
    left_scans(i) = range_image(55 + i);
  end
  
  right_obstacle = false;
  left_obstacle = false;
   
  for i = 1:nr_scans
    if right_scans(i) < 0.05 + min_range
      right_obstacle = true;
      % wb_console_print(sprintf('    Right Obs found at %g', i + 180), WB_STDOUT);
      break;
    end
    if left_scans(i) < 0.05 + min_range
      left_obstacle = true;
      % wb_console_print(sprintf('    Left Obs found at %g', i + 80), WB_STDOUT);
      break;
    end
  end
  
  if right_obstacle
    left_speed  = -0.3 * LEFT_BASE_SPEED;
    right_speed = 0.3 * RIGHT_BASE_SPEED;
    wb_console_print(sprintf('        Turn Left'), WB_STDOUT);
  elseif left_obstacle
    left_speed  = 0.3 * LEFT_BASE_SPEED;
    right_speed = -0.3 * RIGHT_BASE_SPEED;
    wb_console_print(sprintf('        Turn Right'), WB_STDOUT);
  end
  
  wb_motor_set_velocity(left_motor, left_speed);
  wb_motor_set_velocity(right_motor, right_speed);
  
  values = wb_supervisor_field_get_sf_vec3f(trans_field);
  % wb_console_print(sprintf('MY_ROBOT is at position: %g %g %g\n', values(1), values(2), values(3)), WB_STDOUT);
  num_points = wb_lidar_get_number_of_points(lidar);
  point_cloud = wb_lidar_get_point_cloud(lidar);
  
  
  coordinates = zeros(num_points, 2);
  for i = 1:num_points
    if point_cloud(i).z == Inf | point_cloud(i).x == Inf
      continue
    end
    coordinates(i, 1) = point_cloud(i).x;
    coordinates(i, 2) = point_cloud(i).z;
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
