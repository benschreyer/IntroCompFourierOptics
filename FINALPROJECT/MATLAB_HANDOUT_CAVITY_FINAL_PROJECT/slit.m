% Utility function to check if values in y are within a certain range around c
function result = slit(y, c, w)
    % Check if (y - c) is within the window width w
    result = (y - c) < w/2 & (y - c) > -w/2;
end