function plot_imag_1d_line(samples_coordinates, A, name, xunits)
    meter = 1;
    millimeter = 10^(-3) * meter;
    nanometer = 10^(-9) * meter;
    % Default xunits to 'millimeter' if not provided
    if nargin < 4
        xunits = 'millimeter';
    end

    % units for x axis
    samples_plot_coordinates = samples_coordinates;
    if strcmp(xunits, 'millimeter')
        samples_plot_coordinates = samples_plot_coordinates / 1e-3; % 1 millimeter = 1e-3 meters
    end
    
    % Use a stem plot, since the sample count is low
    plot(samples_plot_coordinates, imag(A));
    
    % plotting format
    title([name, ' Imag. Part']);
    
    ylabel('Im(A)');
    
    xlabel(['Displacement Along Slits (', xunits, ')']);
    
    % Save the figure with high resolution (400 DPI)
    saveas(gcf, [name, '_imag.png']);
    
end