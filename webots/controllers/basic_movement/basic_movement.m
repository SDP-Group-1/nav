% MATLAB controller for Webots
% File:          basic_movement.m


TIME_STEP = 64;

% get the motor devices
left_motor = wb_robot_get_device('left wheel motor');
right_motor = wb_robot_get_device('right wheel motor');
% set the target position of the motors
wb_motor_set_position(left_motor, 10.0);
wb_motor_set_position(right_motor, 10.0);

% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the loop when Webots signals the termination
%
while wb_robot_step(TIME_STEP) ~= -1

  % read the sensors, e.g.:
  %  rgb = wb_camera_get_image(camera);

  % Process here sensor data, images, etc.

  % send actuator commands, e.g.:
  %  wb_motor_set_postion(motor, 10.0);

  % if your code plots some graphics, it needs to flushed like this:
  % drawnow;

end

% cleanup code goes here: write data to files, etc.
