function A_normalized = normalize(A)
    A_normalized = A / sqrt(sum(abs(A(:).^2)));
end