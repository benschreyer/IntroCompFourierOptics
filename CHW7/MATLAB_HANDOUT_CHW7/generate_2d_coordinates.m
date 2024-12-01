function coordinates = generate_2d_coordinates(grid_size, grid_dimension)
    % Create a meshgrid for the x and y coordinates
    [x, y] = meshgrid(linspace(-grid_size/2, grid_size/2, grid_size), ...
                      linspace(-grid_size/2, grid_size/2, grid_size));
    
    % Scale by the grid_dimension/grid_size
    x = grid_dimension / grid_size * x;
    y = grid_dimension / grid_size * y;
    
    % Combine the x and y coordinates into a 3D array
    coordinates = cat(3, x, y);
end