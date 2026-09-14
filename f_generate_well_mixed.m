function mat = f_generate_well_mixed(n)
mat = zeros(n, n);
for i = 1: n
    for j = i+1: n
        mat(i, j) = 1;
        mat(j, i) = 1;
    end
end