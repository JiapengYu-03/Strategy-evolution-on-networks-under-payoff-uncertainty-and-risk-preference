function bcratio = f_get_bcratio_average(trans_mat, repro_val, n, retime2, retime3, retime4, Q, p, B, alpha)

trans_mat2 = trans_mat^2;
trans_mat3 = trans_mat^3;
index_dict2 = f_index_dict_two(n);
index_dict3 = f_index_dict_three(n);
index_dict4 = f_index_dict_four(n);

tik1 = 0;
for i = 1: n
    for j = 1: n
        seq = [i, j];
        seq = unique(seq);
        len = length(seq);
        if len == 1
            val = 0;
        else
            index = f_find_index(seq, index_dict2);
            val = retime2(index);
        end
        tik1 = tik1 + (1+Q*p)*repro_val(i)*trans_mat2(i,j)*val;
    end
end


tik2 = 0;
for i = 1: n
    for j = 1: n
        seq = [i, j];
        seq = unique(seq);
        len = length(seq);
        if len == 1
            val = 0;
        else
            index = f_find_index(seq, index_dict2);
            val = retime2(index);
        end
        tik2 = tik2 + repro_val(i)*(trans_mat3(i,j)-trans_mat(i,j))*val;
    end
end


for i = 1: n
    for j = 1: n
        for l = 1: n
            for j1 = 1:n
                seq1 = [j, j1];
                seq1 = unique(seq1);
                len1 = length(seq1);
                if len1 == 1
                    val1 = 0;
                else
                    index1 = f_find_index(seq1, index_dict2);
                    val1 = retime2(index1);
                end
                seq2 = [j, l, j1];
                seq2 = unique(seq2);
                len2 = length(seq2);
                if len2 == 1
                    val2 = 0;
                elseif len2 == 2
                    index2 = f_find_index(seq2, index_dict2);
                    val2 = retime2(index2);
                else
                    index2 = f_find_index(seq2, index_dict3);
                    val2 = retime3(index2);
                end
                seq = [l, j1];
                seq = unique(seq);
                len = length(seq);
                if len == 2
                    tik2 = tik2 + repro_val(i)*trans_mat(i,j)*trans_mat(i,l)*trans_mat(l,j1)*trans_mat(l,j1)*alpha(i)*B*(val2-val1);
                end
            end
        end
    end
end


for i = 1: n
    for j = 1: n
        for l = 1: n
            for j1 = 1:n
                for j2 = 1:n
                    seq1 = [j, j1, j2];
                    seq1 = unique(seq1);
                    len1 = length(seq1);
                    if len1 == 1
                        val1 = 0;
                    elseif len1 == 2
                        index1 = f_find_index(seq1, index_dict2);
                        val1 = retime2(index1);
                    else
                        index1 = f_find_index(seq1, index_dict3);
                        val1 = retime3(index1);
                    end
                    seq2 = [j, l, j1, j2];
                    seq2 = unique(seq2);
                    len2 = length(seq2);
                    if len2 == 1
                        val2 = 0;
                    elseif len2 == 2
                        index2 = f_find_index(seq2, index_dict2);
                        val2 = retime2(index2);
                    elseif len2 == 3
                        index2 = f_find_index(seq2, index_dict3);
                        val2 = retime3(index2);
                    else
                        index2 = f_find_index(seq2, index_dict4);
                        val2 = retime4(index2);
                    end
                    seq = [l, j1, j2];
                    seq = unique(seq);
                    len = length(seq);
                    if len == 3
                        tik2 = tik2 + repro_val(i)*trans_mat(i,j)*trans_mat(i,l)*trans_mat(l,j1)*trans_mat(l,j2)*alpha(i)*B*(val2-val1);
                    end
                end
            end
        end
    end
end


bcratio = tik1/tik2;