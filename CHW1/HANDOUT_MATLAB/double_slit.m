function res = double_slit(x, l)
    % Initialize result array with zeros
    res = zeros(size(x)); % Create an array of zeros with the same size as x
    
    % Define the conditions for each slit
    condition1 = (-l * 0.15 < x) & (x < -0.1 * l);
    condition2 = (l * 0.1 < x) & (x < 0.15 * l);
    
    % Add up each slit in the pattern
    res = res + condition1;
    res = res + condition2;
end