function [amplitude, power] = propagate_roundtrip(coordinates, amplitude, power, aperture, R)
    % Define units in meters
    millimeter = 1e-3;  % 1 mm = 1e-3 meters
    nanometer = 1e-9;   % 1 nm = 1e-9 meters
    meter = 1;          % 1 m = 1 meter

    % Speed of light in m/s
    c = 3 * 10^8 * meter; % m/s

    % Simulation points
    N = 256;

    % Size of simulation
    D = %10x the gaussian aperture size

    % Light wavelength
    lamb = 1000 * nanometer;

    % Reflectivity of the output mirror
    R = 0.85;

    % Cavity mirror focal lengths, the curvature of a mirror can provide the same lensing as a non-vacuum material lens
    f1 = 2.0 * meter;
    f2 = 5 * meter;

    % Parameters of the length L gain medium
    Isat = 120 * 10^4;
    alpha = 0.5;

    % Power in Watts
    power = 1;

    % Power of random radiation, should be much less than our expected
    % saturated power
    power_random = 0.0001;

    % Cavity length
    L = 300 * millimeter;

    % Number of bounces to make on the laser amplitude
    iterations = 400;

    % Roundtrip time for the beam assuming it is nearly axial
    dt = 2 * L / c;
    
   

    % Add the power-weighted amplitude to the random amplitude
    
    amplitude = amplitude + random_amplitude(coordinates) *%...
    
    %Calculate and store the new resultant power, then normalize
    %...

    %Apply the aperture to the normalized field
    %...

    %The field is no longer normalized after aperturing, in fact the remaining
    %square sum gives the fraction of power remaining after
    %the aperture, calculate and store a new power
    %...


    % Apply the aperture side lensing due to the mirror curvature
    amplitude = amplitude .* lens(%...);

    % Propagate through the gain medium
    % This is approximated as a vacuum propagation L
    % and then a gain factor dependent on intensity


    [amplitude] = propagate_fresnel_transfer_2d(%...);
    amplitude = normalize(amplitude);
    amplitude = amplitude .* gain_sheet_saturable(coordinates, amplitude, Isat, alpha, power, L);

    % Normalize the intensity after the propagation and gain, but save the 
    % gain-increased power first
    power = %...

    % Apply exit side mirror and normalize
    amplitude = amplitude .* lens(%...);
    
    
    % Reduce the power in the cavity since (1 - R)
    % escapes the cavity at mirror 2
    power = power * %...;

    % Propagate back to plane 1
    [amplitude] = propagate_fresnel_transfer_2d(%...);
    %Normalize...
end
