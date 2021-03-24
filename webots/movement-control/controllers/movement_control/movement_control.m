
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

target_alpha = 0.10;

while wb_robot_step(TIME_STEP) ~= -1
  x_y_z_alpha_array = wb_supervisor_field_get_sf_rotation(or_field);
  curr_alpha = x_y_z_alpha_array(4);
  
  %Rounded to 2 decimals because otherwise it would be too slow and because target alpha is 0.10
  if round(curr_alpha,2) ~= target_alpha
  wb_console_print(sprintf('curr alpha: %g, target alpha: %g.\n', round(curr_alpha,2), target_alpha), WB_STDOUT);
  wb_motor_set_velocity(left_motor, -0.01);
  wb_motor_set_velocity(right_motor, 0.01);
  else
  wb_console_print(sprintf('curr alpha: %g, target alpha: %g.\n', round(curr_alpha,2), target_alpha), WB_STDOUT);
  wb_console_print(sprintf('Continuing straight'), WB_STDOUT);
  wb_motor_set_velocity(left_motor, LEFT_BASE_SPEED);
  wb_motor_set_velocity(right_motor, RIGHT_BASE_SPEED);
  end
  
end


% cleanup code goes here: write data to files, etc.