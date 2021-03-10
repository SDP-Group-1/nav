% MATLAB controller for Webots
% File:          basic_movement.m


TIME_STEP = 600;

BASE_SPEED = 1.5;

% get the motor devices
left_motor = wb_robot_get_device('left wheel motor');
right_motor = wb_robot_get_device('right wheel motor');

% set the target position of the motors
wb_motor_set_position(left_motor, Inf);
wb_motor_set_position(right_motor, Inf);

% set up the motor speeds at 10% of the MAX_SPEED.
wb_motor_set_velocity(left_motor, 1);
wb_motor_set_velocity(right_motor, 2);

% get and initialise the lidar device
lidar = wb_robot_get_device('Hokuyo URG-04LX');
wb_lidar_enable(lidar, TIME_STEP);
lidar_samples = wb_lidar_get_horizontal_resolution(lidar);
lidar_field_of_view = wb_lidar_get_fov(lidar);

while wb_robot_step(TIME_STEP) ~= -1

  wb_motor_set_velocity(left_motor, 1);
  wb_motor_set_velocity(right_motor, 2);
  
  lidar_values = wb_lidar_get_range_image(lidar)
  display(display_b, display_b_width, display_b_height, urg04lx_values, urg04lx_samples, urg04lx_field_of_view);
  
end

% cleanup code goes here: write data to files, etc.
