function aperture = grid_aperture(coordinates, r_outer, arm_thickness, N_x, N_y, sq)

    % An open aperture
    aperture = ones(size(coordinates(:,:,1)));
    
    % Calculate the squared radius at each coordinate point
    r_squared = coordinates(:,:,1).^2 + coordinates(:,:,2).^2;
    
    %Outer circular aperture zeroed, since it is blocked
    %Zero an outer aperture (possibly square or circular shape)
    %...
        
    %N_x/y bars will separate N_x/y + 1 regions, find the size of these regions to find the bar spacing
    %...
    
    %Iterate horizontal and vertical gridlines
    %...
end