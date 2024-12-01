function aperture = spider_aperture(coordinates, r_outer, arm_thickness, N_arm, sq)

    % An open aperture initialized to 1.0
    aperture = ones(size(coordinates(:,:,1)));
    
    % Calculate the squared radius at each coordinate point
    r_squared = coordinates(:,:,1).^2 + coordinates(:,:,2).^2;
    
    % Outer circular aperture zeroed, or square
    if ~sq
        % Zero out values outside the circular radius
        aperture(r_squared > r_outer^2) = 0.0;
    else
        % Square case: zero out values outside the square boundaries
        aperture(coordinates(:,:,1) > r_outer) = 0.0;
        aperture(coordinates(:,:,1) < -r_outer) = 0.0;
        aperture(coordinates(:,:,2) < -r_outer) = 0.0;
        aperture(coordinates(:,:,2) > r_outer) = 0.0;
    end
    
    % Create a blocking arm primitive initialized to 1.0
    arm_primitive = ones(size(coordinates(:,:,1)));
    
    % Define the arm within specified thickness
    arm_primitive(coordinates(:,:,1) > -0.02 * r_outer & ...
                  coordinates(:,:,1) < r_outer * 2 & ...
                  coordinates(:,:,2) < arm_thickness / 2 & ...
                  coordinates(:,:,2) > -arm_thickness / 2) = 0.0;
    
    % Impose rotated blocking arms to create the "spider" aperture
    for i = 0:(N_arm - 1)
        % Rotate the arm primitive by the appropriate angle
        angle = i * 360 / N_arm;
        arm_rot = rotate_image(arm_primitive, angle);
        aperture = aperture .* arm_rot;
    end
    
    % Round up all aperture values to create a binary aperture
    aperture(aperture > 0.5) = 1.0;
end