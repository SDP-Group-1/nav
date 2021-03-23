
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


% target coordinates
target_x = 0.000000105497;
target_z = -1.39709;

while wb_robot_step(TIME_STEP) ~= -1
  
  wb_motor_set_velocity(left_motor, LEFT_BASE_SPEED);
  wb_motor_set_velocity(right_motor, RIGHT_BASE_SPEED);
  
  % get current location
  trans_values = wb_supervisor_field_get_sf_vec3f(trans_field);
  x_y_z_alpha_array = wb_supervisor_field_get_sf_rotation(or_field);
  
  curr_x = trans_values(1);
  curr_z = trans_values(3);
  curr_alpha = x_y_z_alpha_array(4);
  wb_console_print(sprintf('MY_ROBOT is at position (x=%g, z=%g)\n', curr_x, curr_z), WB_STDOUT);  
  
  wb_console_print(sprintf('    target location x=%g, z=%g.\n', target_x, target_z), WB_STDOUT);  
    
  % calculate distance to move
  curr_dist_to_move_x = target_x - curr_x;
  curr_dist_to_move_z = target_z - curr_z;
  wb_console_print(sprintf('    curr_dist_to_move x=%g, z=%g.\n', curr_dist_to_move_x, curr_dist_to_move_z), WB_STDOUT);  
  
  x_sq = power(curr_dist_to_move_x, 2);
  z_sq = power(curr_dist_to_move_z, 2);
  wb_console_print(sprintf('    squared x=%g, z=%g.\n', x_sq, z_sq), WB_STDOUT);  
  
  dist_to_move = sqrt(x_sq + z_sq);
  wb_console_print(sprintf('    %g ditance left to move.\n', dist_to_move), WB_STDOUT);  
  
  wb_motor_set_velocity(left_motor, - curr_dist_to_move_x* 0.1);
  wb_motor_set_velocity(right_motor, curr_dist_to_move_x * 0.1);
  
end


% cleanup code goes here: write data to files, etc.