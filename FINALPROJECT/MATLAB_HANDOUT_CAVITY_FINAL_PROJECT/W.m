function output = W(z, W0, M2, z0, lambda)
    % Calculate the beam width at a distance z
    output = sqrt(W0.^2 + (M2.^2 .* (lambda ./ (pi .* W0)).^2) .* (z - z0).^2);
end