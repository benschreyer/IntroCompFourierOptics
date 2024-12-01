function result = lens(coordinates, f, lambda)
    % Sum of x,y coordinates squared gives the squared distance from the 0 coordinate
    r_sq_field = (coordinates(:,:,1).^2 + coordinates(:,:,2).^2);
    
    % Lens phase angle field
    phi = pi * r_sq_field / (lambda * f);
    
    % Exponential of the complex number
    result = exp(1i * phi);
end