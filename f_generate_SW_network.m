function A = f_generate_SW_network(N, K, p)
% N: 节点数
% K: 每个节点连接 K 个最近邻（K 应为偶数）
% p: 重连概率
% 返回值 A: 邻接矩阵

if mod(K,2) ~= 0
    error('K must be even.');
end

A = zeros(N);  % 初始化邻接矩阵

% 1. 构建规则环形图
for i = 1:N
    for j = 1:(K/2)
        neighbor = mod(i - j - 1, N) + 1;
        A(i, neighbor) = 1;
        A(neighbor, i) = 1;
    end
end

% 2. 重连部分边（按概率p）
for i = 1:N
    for j = 1:(K/2)
        neighbor = mod(i - j - 1, N) + 1;
        if rand < p
            % 尝试重连，避免自环与重复边
            A(i, neighbor) = 0;
            A(neighbor, i) = 0;
            new_neighbor = i;
            while new_neighbor == i || A(i, new_neighbor) == 1
                new_neighbor = randi(N);
            end
            A(i, new_neighbor) = 1;
            A(new_neighbor, i) = 1;
        end
    end
end
end
