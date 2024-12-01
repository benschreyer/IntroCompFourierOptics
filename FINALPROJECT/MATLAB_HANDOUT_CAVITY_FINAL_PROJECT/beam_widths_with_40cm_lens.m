function [zs, wxs, wys] = beam_widths_with_40cm_lens(coordinates, ampl, plot_flag)
        % Define units in meters
    millimeter = 1e-3;  % 1 mm = 1e-3 meters
    nanometer = 1e-9;   % 1 nm = 1e-9 meters
    meter = 1;          % 1 m = 1 meter

    % Speed of light in m/s
    c = 3 * 10^8 * meter; % m/s

    % Simulation points
    N = 256;

    % Size of simulation
    D = 10 * millimeter;

    % Light wavelength
    lamb = 1000 * nanometer;
    % Negative focal length for focusing!
    amplitude = ampl .* lens(coordinates, -400 * millimeter, lamb);

    % Arrays to store the measured beam widths over propagation distances zs
    wxs = [];
    wys = [];
    zs = [];

    % 40 propagation points should be sufficient, start propagating
    % to a distance of 100mm where Fresnel approximation holds
    for i = 0:39
        [ap] = propagate_fresnel_transfer_2d(%...)
        
        if plot_flag
            figure;
            plot_2d_intensity(coordinates, ap, sprintf('Z = %d mm', round((%...)));
            drawnow;
        end

        %Existing function will calculate the beam width, notably two times scaled smaller of the D4sigma width
        [wx, wy, cx, cy] = %... calculate the width and centroid of the transverse amplitude
        zs = [zs,%...];
        wxs = [wxs, wx];
        wys = [wys, wy];
    end
end