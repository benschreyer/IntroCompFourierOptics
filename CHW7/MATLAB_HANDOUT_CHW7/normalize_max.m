function A_normalized = normalize_max(A)
    % Normalize the amplitude such that the maximum intensity is 1.0
    % A is the input amplitude field

    % Calculate the maximum intensity
    max_intensity = max(abs(A(:)).^2);
    
    % Normalize the amplitude if the maximum intensity is not zero
    if max_intensity > 0
        A_normalized = A / sqrt(max_intensity);
    else
        A_normalized = A; % If the maximum intensity is zero, return the original amplitude
    end
end