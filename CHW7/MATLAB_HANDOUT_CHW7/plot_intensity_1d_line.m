function plot_intensity_1d_line(samples_coordinates, A, name, xunits)
    meter = 1;
    millimeter = 10^(-3) * meter;
    nanometer = 10^(-9) * meter;
    % Set default argument for xunits
    if nargin < 4
        xunits = 'millimeter';
    end
    
    % Units for x axis
    samples_plot_coordinates = samples_coordinates;
    if strcmp(xunits, 'millimeter')
        samples_plot_coordinates = samples_plot_coordinates / millimeter;
    end
    
    
    plot(samples_plot_coordinates, 1/2 * abs(A).^2, '-');
    
    % Plot formatting
    title([name, ' Intensity Samples']);
    
    ylabel('Intensity (W/m)');
    
    xlabel(['Displacement Along Slits (' xunits ')']);
    
    % Save the plot as an image
    saveas(gcf, strrep(char(strcat([name '_intensity'])), ' ', '_'), 'png');
end