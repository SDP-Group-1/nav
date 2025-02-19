% MATLAB controller for Webots


TIME_STEP = 100;

LEFT_BASE_SPEED = 6;
RIGHT_BASE_SPEED = 6;

% set up supervisor
robot_node = wb_supervisor_node_get_self();

if robot_node == 0
  wb_console_print('No DEF MY_ROBOT node found in the current world file', WB_STDERR);
  quit(1);
end

trans_field = wb_supervisor_node_get_field(robot_node, 'translation');
wb_keyboard_enable(TIME_STEP);

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

num_scans = 300;
webots_scans = lidarScan.empty(num_scans,0);
scan_index = 1;

while wb_robot_step(TIME_STEP) ~= -1

  left_speed  = 0;
  right_speed = 0;
   
  % update speeds based on keyboard input

  key = wb_keyboard_get_key();
  
  if key > 0
    if key == WB_KEYBOARD_UP
      left_speed  = LEFT_BASE_SPEED;
      right_speed = RIGHT_BASE_SPEED;
    elseif key == WB_KEYBOARD_RIGHT
      left_speed  = LEFT_BASE_SPEED;
      right_speed = -RIGHT_BASE_SPEED;
    elseif key == WB_KEYBOARD_LEFT
      left_speed  = -LEFT_BASE_SPEED;
      right_speed = RIGHT_BASE_SPEED;
    else
      % wb_console_print(sprintf('STOPPING'), WB_STDOUT);
      % save('../../webotsLidarReadings.mat', 'webots_scans')
      % return
    end
  end
  
  wb_motor_set_velocity(left_motor, left_speed);
  wb_motor_set_velocity(right_motor, right_speed);

  values = wb_supervisor_field_get_sf_vec3f(trans_field);
  % wb_console_print(sprintf('MY_ROBOT is at position: %g %g %g\n', values(1), values(2), values(3)), WB_STDOUT);

  point_cloud = wb_lidar_get_point_cloud(lidar);
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

  wb_console_print(sprintf('scan_index: %g', scan_index), WB_STDOUT);
  
  scan_index = scan_index + 1;
  
end



% cleanup code goes here: write data to files, etc.
