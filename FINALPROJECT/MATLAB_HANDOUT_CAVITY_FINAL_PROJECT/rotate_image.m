function rotated_img = rotate_image(img, angle)
    % Function to rotate a 2D image by a specified angle using MATLAB's imrotate function
    % 'crop' behavior implemented to maintain the original image size
    rotated_img = imrotate(img, angle, 'bilinear', 'crop');
end