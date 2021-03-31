TIME_STEP = 100;

robot_node = wb_supervisor_node_get_self();
trans_field = wb_supervisor_node_get_field(robot_node, 'translation');
or_field = wb_supervisor_node_get_field(robot_node, 'rotation');

origin_location = wb_supervisor_field_get_sf_vec3f(trans_field);

% get the motor devices
left_motor = wb_robot_get_device('left wheel motor');
right_motor = wb_robot_get_device('right wheel motor');

% set the target position of the motors
wb_motor_set_position(left_motor, Inf);
wb_motor_set_position(right_motor, Inf);

BASE_SPEED = 3;

% BUILD THE OCCUPANCY GRID
while wb_robot_step(TIME_STEP) ~=1

  % if occupancy file doesn't exist
  if ~isfile('occupancy_grid.mat')
    wb_console_print(sprintf('DID NOT FIND OCCUPANCY GRID FILE'), WB_STDOUT);
    % TODO
    % must create it ourselves
    % continue / start creating scans
    % once reached a limit, create occupancy grid.

  else
    wb_console_print(sprintf('FOUND OCCUPANCY GRID FILE'), WB_STDOUT);
    break
    
  end
end

% initialise for main loop
load('occupancy_grid.mat');
path = [];
path_state_index = 5;


while wb_robot_step(TIME_STEP) ~= -1  
  
  curr_location = wb_supervisor_field_get_sf_vec3f(trans_field);
  curr_or = wb_supervisor_field_get_sf_rotation(or_field);

  wb_console_print(sprintf('LOCATION: (x=%g, z=%g) ', curr_location(1), curr_location(3)), WB_STDOUT);
   
  if ~isfile('fallen_person_coordinate.mat')
    wb_console_print(sprintf('DID NOT FIND FALLEN PERSON COORDINATE FILE'), WB_STDOUT);
    % if not at origin
      % TODO
      % traverse route plan backwards back to origin
      
    % continue to next loop
    continue;
  end
  
  fallen_person_coordinate = load('./fallen_person_coordinate.mat');
  fallen_person_coordinate = [fallen_person_coordinate.x, fallen_person_coordinate.z];
  
  if has_reached_coordinate(curr_location, fallen_person_coordinate)
    wb_console_print(sprintf('    HAS REACHED PERSON'), WB_STDOUT);
    % if still in use by person (person holding handles)
      % TODO      
    
    % else
      % delete coordinate file since we not longer need to assist person
      
    continue;
  end
  
  % if we reach this part, we still need to get to the person
  if isempty(path)
    wb_console_print(sprintf('    PLANNED PATH DOES NOT EXIST'), WB_STDOUT);
    path = build_path(curr_location, fallen_person_coordinate, map);
  end
  
  [left_velocity_mult, right_velocity_mult, path_state_index] = follow_path(path, curr_location, path_state_index, curr_or);
  
  wb_motor_set_velocity(left_motor, BASE_SPEED * left_velocity_mult);
  wb_motor_set_velocity(right_motor, BASE_SPEED * right_velocity_mult);
  
  % TODO: implement move function
    % move along the planned route to find the person

end

function [left_velocity_mult, right_velocity_mult, path_state_index] = follow_path(path, curr_location, path_state_index, curr_or)
  wb_console_print(sprintf('    FOLLOWING PATH'), WB_STDOUT);
  
  x_origin_webots = 1.51232;
  z_origin_webots = 0.705706;
  
  target_x = path.States(path_state_index,1) + x_origin_webots;
  target_z = - path.States(path_state_index,2) + z_origin_webots;
  target_coordinate = [target_x, target_z];
  
  curr_x = curr_location(1);
  curr_z = curr_location(3);
  
  left_velocity_mult = 0;
  right_velocity_mult = 0;
  
  target_x
  target_z
  
  
  if has_reached_coordinate(curr_location, target_coordinate)
    path_state_index = path_state_index + 1
    return;
  end
  
<<<<<<< HEAD
  
  % if is_correct_angle()
    
    % left_velocity_mult = 1;
    % right_velocity_mult = 1;
  
  % elseif
    % TODO implement angle bs
    % ur jobbo :) ? :'( 
  % end
=======
  if is_correct_angle(curr_location, target_coordinate, curr_or)
    wb_console_print(sprintf('MOVING FORWARD'), WB_STDOUT);

    left_velocity_mult = 1;
    right_velocity_mult = 1;
  
  else
    curr_x = curr_location(1);
    curr_z = curr_location(3);
  
    target_x = target_coordinate(1);
    target_z = target_coordinate(2);
  
    target_alpha1 = atan((target_x-curr_x)/(target_z-curr_z));

    target_alpha = atan2((target_z-curr_z),(target_x-curr_x));
    curr_alpha = curr_or(4);
    
    if round(target_alpha,3) < round(curr_alpha,3)
    wb_console_print(sprintf('curr alpha: %g, target alpha: %g.\n', round(curr_alpha,3), round(target_alpha,3)), WB_STDOUT);
    left_velocity_mult = -0.1;
    right_velocity_mult = 0.1;
    else
    wb_console_print(sprintf('curr alpha: %g, target alpha: %g.\n', round(curr_alpha,3), round(target_alpha,3)), WB_STDOUT);
    left_velocity_mult = 0.1;
    right_velocity_mult = -0.1;
    end
  end
>>>>>>> 74fcaf1601ab71927800ee7eb4fde36d9833f3f1
  
end

function has_reached = has_reached_coordinate(curr_location, target_coordinate)
  
  curr_x = curr_location(1);
  curr_z = curr_location(3);
    
  % calculate distance to move
  curr_dist_to_move_x = target_coordinate(1) - curr_x;
  curr_dist_to_move_z = target_coordinate(2) - curr_z;
  
  x_sq = power(curr_dist_to_move_x, 2);
  z_sq = power(curr_dist_to_move_z, 2);
  
  dist_to_move = sqrt(x_sq + z_sq);
  wb_console_print(sprintf('    %g ditance left to move.\n', dist_to_move), WB_STDOUT);  
  
  has_reached = dist_to_move < 0.2;

end

function path = build_path(curr_location, fallen_person_coordinate, map)

  wb_console_print(sprintf('    BUILDING PATH'), WB_STDOUT);
  
  bounds = [map.XWorldLimits; map.YWorldLimits; [-pi pi]];

  ss = stateSpaceDubins(bounds);
  ss.MinTurningRadius = 0.4;
  
  stateValidator = validatorOccupancyMap(ss); 
  stateValidator.Map = map;
  stateValidator.ValidationDistance = 0.05;
  
  planner = plannerRRT(ss, stateValidator);
  planner.MaxConnectionDistance = 2.0;
  planner.MaxIterations = 30000;
  
  rng(0,'twister');
  
  x_origin_webots = 1.51232;
  z_origin_webots = 0.705706;
  
  start = [curr_location(1) - x_origin_webots, curr_location(3) - z_origin_webots, 0];
  goal = [fallen_person_coordinate(1), fallen_person_coordinate(2), 0];
  [path, solnInfo] = plan(planner, start, goal);
  
  save('path.mat', 'path');
  
end

function correct_alpha = is_correct_angle(curr_location, target_coordinate, curr_or)
  
  curr_x = curr_location(1);
  curr_z = curr_location(3);
  
  target_x = target_coordinate(1);
  target_z = target_coordinate(2);
  
  target_alpha = atan((target_x-curr_x)/(target_z-curr_z));

  target_alpha1 = atan2((target_z-curr_z),(target_x-curr_x));
  curr_alpha = curr_or(4);
  
  correct_alpha = (abs(target_alpha) > abs(curr_alpha) - 0.05) && (abs(target_alpha) < abs(curr_alpha) + 0.05);
end
  