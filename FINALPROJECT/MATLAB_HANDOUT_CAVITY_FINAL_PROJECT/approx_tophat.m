function result = approx_tophat(x, w)
    summed = 0;
    for i = 0:12
        term = 1/(i * 2 + 1) * sin((i * 2 + 1) * pi * x / w);
        summed = summed + term;
    end
    result = 4 / pi * summed;
end