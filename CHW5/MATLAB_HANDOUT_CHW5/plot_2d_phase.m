function plot_2d_phase(coordinates, amplitude, name)
    meter = 1;
    millimeter = 10^(-3) * meter;
    nanometer = 10^(-9) * meter;
    if nargin < 3
        name = ''; % Default value for name
    end
    

    jet_wrap = vertcat(jet,flipud(jet));
    % Use a cyclic colormap and disable interpolation
    phase_data = angle(amplitude) + pi; % Shift phase from [-pi, pi] to [0, 2*pi]
    imagesc([min(coordinates(:)) millimeter max(coordinates(:)) millimeter], ...
            [min(coordinates(:)) millimeter max(coordinates(:)) millimeter], ...
            phase_data);
    
    colormap(jet_wrap);
    title([name, ' 2D Phase']);
    caxis([0 2 * pi]); % Set color axis limits
    axis xy; % Ensure the correct orientation
    xlabel('x (mm)');
    ylabel('y (mm)');
    colorbar;
    saveas(gcf, [name, '_phase.png']);
end