function plot_2d_intensity(coordinates, amplitude, name)
    meter = 1;
    millimeter = 10^(-3) * meter;
    nanometer = 10^(-9) * meter;
    if nargin < 3
        name = ''; % Default value for name
    end
    


    
    colormap('jet');
    % Normalize and compute intensity
    intensity = abs(normalize_max(amplitude)).^2;
    imagesc([min(coordinates(:))/millimeter max(coordinates(:))/millimeter], ...
            [min(coordinates(:))/millimeter max(coordinates(:))/millimeter], ...
            intensity);
    title([name, ' 2D Intensity']);
    xlabel('x (mm)');
    ylabel('y (mm)');
    colorbar;
    %filname invalid for no reason.
    saveas(gcf, strrep(char(strcat([name '_intensity'])), ' ', '_'),'png');
end