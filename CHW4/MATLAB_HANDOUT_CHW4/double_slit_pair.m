% function that defines the 1D slit pattern for a double slit pair
function res = double_slit_pair(x)
    meter = 1;
    millimeter = 10^(-3) * meter;
    nanometer = 10^(-9) * meter;
    
    % slit parameters
    slit_separation = 0.2 * millimeter;
    slit_width = 0.1 * millimeter;
    pair_separation = 1 * millimeter;
    
    % Assemble the four slits, we can just add each slit, since they don't overlap
    res = slit(x, pair_separation/2 + slit_separation/2, slit_width);
    res = res + slit(x, pair_separation/2 - slit_separation/2, slit_width);
    
    res = res + slit(x, -pair_separation/2 + slit_separation/2, slit_width);
    res = res + slit(x, -pair_separation/2 - slit_separation/2, slit_width);
    
end