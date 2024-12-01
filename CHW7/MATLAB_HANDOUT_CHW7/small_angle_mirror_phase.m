function phasor = small_angle_mirror_phase(coordinates, photon_lambda, angle, axis)
    if nargin < 4
        axis = 'y'; % Default value for axis
    end
    
    if angle > 0.2
        disp('Not a small angle mirror');
    end
    
    if strcmp(axis, 'y')
        phasor = exp(1.0i * 2 * pi * 2 * angle * coordinates(:,:,1) / photon_lambda);
    else
        phasor = exp(1.0i * 2 * pi * 2 * angle * coordinates(:,:,2) / photon_lambda);
    end
end
