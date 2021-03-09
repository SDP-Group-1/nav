% MATLAB controller for Webots
% File:          basic_movement.m


TIME_STEP = 64;

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

% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the loop when Webots signals the termination
%
while wb_robot_step(TIME_STEP) ~= -1

  wb_motor_set_velocity(left_motor, 1);
  wb_motor_set_velocity(right_motor, 2);

end

% cleanup code goes here: write data to files, etc.
