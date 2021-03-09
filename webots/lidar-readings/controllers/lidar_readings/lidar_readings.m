% MATLAB controller for Webots
% File:          basic_movement.m


TIME_STEP = 64;

BASE_SPEED = 1.5;

% get the motor devices
left_motor = wb_robot_get_device('left wheel motor');
right_motor = wb_robot_get_device('right wheel motor');

% get and initialise the lidar device
lidar = wb_robot_get_device('LDS-01');
wb_lidar_enable(lidar, TIME_STEP);
wb_lidar_enable_point_cloud(lidar);

% get lidar motor and enable rotation (only for visualization, no effect on the sensor)
lidar_main_motor = wb_robot_get_device('LDS-01_main_motor');
lidar_secondary_motor = wb_robot_get_device('LDS-01_secondary_motor');
wb_motor_set_position(lidar_main_motor, Inf);
wb_motor_set_position(lidar_secondary_motor, Inf);
wb_motor_set_velocity(lidar_main_motor, 30.0);
wb_motor_set_velocity(lidar_secondary_motor, 60.0);

% set the target position of the motors
wb_motor_set_position(left_motor, Inf);
wb_motor_set_position(right_motor, Inf);

% set up the motor speeds at 10% of the MAX_SPEED.
wb_motor_set_velocity(left_motor, 1);
wb_motor_set_velocity(right_motor, 2);

lidar_width = wb_lidar_get_horizontal_resolution(lidar);
lidar_max_range = wb_lidar_get_max_range(lidar);

% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the loop when Webots signals the termination
%
while wb_robot_step(TIME_STEP) ~= -1

  wb_motor_set_velocity(left_motor, 1);
  wb_motor_set_velocity(right_motor, 2);
  
  lidar_values = wb_lidar_get_range_image(lidar)

end

% cleanup code goes here: write data to files, etc.
