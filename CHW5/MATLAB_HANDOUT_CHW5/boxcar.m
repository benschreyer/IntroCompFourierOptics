function result = boxcar(x, w)
    result = (x > -w/2) & (x < w/2);
end