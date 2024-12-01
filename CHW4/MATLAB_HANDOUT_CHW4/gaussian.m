% A gaussian utility function
function g = gaussian(x, sigma)
    g = exp(-((x / sigma).^2));
end