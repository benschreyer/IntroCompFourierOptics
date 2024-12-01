function propagate_and_plot_boxcar(coordinates, boxcar_amplitude, L, method)
    if nargin < 4
        method = 'Fresnel'; % Default method
    end
    
    propagate_fn = @propagate_fraunhofer;
    if strcmp(method, 'Fresnel')
        propagate_fn = @propagate_fresnel;
    end
    lambda = 500 * 10^-9
    [propagated_coordinates, propagated_boxcar_amplitude] = propagate_fn(coordinates, boxcar_amplitude, lambda, L);
    
    % Call plot_intensity_1d_line with the same arguments
    plot_intensity_1d_line(propagated_coordinates, propagated_boxcar_amplitude, ...
        ['Boxcar-prop-w ' method '-L-' num2str(L) 'm']);
end