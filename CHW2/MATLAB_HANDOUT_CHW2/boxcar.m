function bc = boxcar(x, width)
    % Create a boxcar (rectangular) window of specified width
    bc = double(abs(x) <= width / 2);
end
