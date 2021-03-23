% MATLAB controller for Webots
% File:          basic_movement.m


TIME_STEP = 2000;

LEFT_BASE_SPEED = 3;
RIGHT_BASE_SPEED = 3;

% Set the start and goal poses
start = [0, 0, 0];
goal = [1.5, -2, 0];

% set up supervisor
robot_node = wb_supervisor_node_get_self();

if robot_node == 0
  wb_console_print('No DEF MY_ROBOT node found in the current world file', WB_STDERR);
  quit(1);
end

trans_field = wb_supervisor_node_get_field(robot_node, 'translation');
or_field = wb_supervisor_node_get_field(robot_node, 'rotation');
% get the motor devices
left_motor = wb_robot_get_device('left wheel motor');
right_motor = wb_robot_get_device('right wheel motor');

% set the target position of the motors
wb_motor_set_position(left_motor, Inf);
wb_motor_set_position(right_motor, Inf);

% set up the motor speeds at 10% of the MAX_SPEED.
wb_motor_set_velocity(left_motor, LEFT_BASE_SPEED);
wb_motor_set_velocity(right_motor, RIGHT_BASE_SPEED);

while wb_robot_step(TIME_STEP) ~= -1

  wb_motor_set_velocity(left_motor, LEFT_BASE_SPEED);
  wb_motor_set_velocity(right_motor, RIGHT_BASE_SPEED);
  
  trans_values = wb_supervisor_field_get_sf_vec3f(trans_field);
  x_y_z_alpha_array = wb_supervisor_field_get_sf_rotation(or_field);
  wb_console_print(sprintf('MY_ROBOT is at position: %g %g %g\n', trans_values(1), trans_values(2), trans_values(3)), WB_STDOUT);
  wb_console_print(sprintf('Rotation of %g radians around %g %g %g\n', x_y_z_alpha_array(4), x_y_z_alpha_array(1), x_y_z_alpha_array(2), x_y_z_alpha_array(3)), WB_STDOUT);  
  
end



% cleanup code goes here: write data to files, etc.