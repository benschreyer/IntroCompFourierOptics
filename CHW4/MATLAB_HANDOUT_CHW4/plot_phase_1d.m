function plot_phase_1d(sample_coordinates, A, name, xunits)
    % Define units in meters
    meter = 1; % meter
    
    % Define millimeter and nanometer in terms of meters
    millimeter = 10^-3 * meter; % millimeter
    nanometer = 10^-9 * meter; % nanometer
    % Set default value for xunits if not provided
    if nargin < 4
        xunits = 'millimeter';
    end

    % Units for x axis
    if strcmp(xunits, 'millimeter')
        samples_plot_coordinates = sample_coordinates / millimeter;
    else
        samples_plot_coordinates = sample_coordinates;
    end

    % Use a stem plot, since the sample count is low
    figure;
    stem(samples_plot_coordinates, angle(A), 'x', 'DisplayName', 'Sampled Points');

    % Plotting format
    title([name ' Phase Samples']);
    ylabel('Phase (rad)');
    xlabel(['Displacement Along Slits (' xunits ')']);
    legend('show');

    % Save the figure as an image file
    saveas(gcf, [name '_phase.png'], 'png');

    % Display the plot
    hold off;
end