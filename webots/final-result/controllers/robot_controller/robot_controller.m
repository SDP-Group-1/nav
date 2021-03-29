TIME_STEP = 100;

% BUILD THE OCCUPANCY GRID
while wb_robot_step(TIME_STEP) ~=1

  % if occupancy file doesn't exist
    % must create it ourselves
    % continue / start creating scans
    % once reached a limit, create occupancy grid.

  % else
    % break
end

while wb_robot_step(TIME_STEP) ~= -1  
  
  % if fallen person file with coordinates doesn't exist
    % if not at origin
      % traverse route plan backwards back to origin
      
    % continue to next loop
      
    
  % else if have reached coordinates
    % if still in use by person (person holding handles)
      
    
    % else
      % delete coordinate file
      
    % continue to next loop
      
      
  % if route plan file doesn't exist
    % create file
  
  % move along the planned route to find the person

end