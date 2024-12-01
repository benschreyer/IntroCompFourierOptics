function [Ex, Ey] = centroid(coordinates, amplitude)
    % Normalize the amplitude
    amplitude_normalized = normalize(amplitude);
    
    % Calculate the expected value for x, which is the x centroid given normalization
    Ex = %%%sum to approx integral (%%%Fill in .* abs(amplitude_normalized).^2) ;
    
    % Calculate the expected value for y, which is the x centroid given normalization
    Ey = %%%sum to approx integral (%%%Fill in .* abs(amplitude_normalized).^2);
end