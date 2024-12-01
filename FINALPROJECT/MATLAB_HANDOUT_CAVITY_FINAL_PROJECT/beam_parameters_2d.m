function [width_x, width_y, centroid_x, centroid_y] = beam_parameters_2d(coordinates, A)
    % Normalize A
    An = normalize(A);

    % Calculate the expected values for x^2 and x (centroid in x direction)
    Ex2 = sum(sum(coordinates(:,:,1).^2 .* abs(An).^2));
    Ex = sum(sum(coordinates(:,:,1) .* abs(An).^2));

    % Calculate the expected values for y^2 and y (centroid in y direction)
    Ey2 = sum(sum(coordinates(:,:,2).^2 .* abs(An).^2));
    Ey = sum(sum(coordinates(:,:,2) .* abs(An).^2));

    % Calculate the width based on the variance (standard deviation) and return the centroid
    width_x = sqrt(Ex2 - Ex^2);
    width_y = sqrt(Ey2 - Ey^2);
    centroid_x = Ex;
    centroid_y = Ey;
end