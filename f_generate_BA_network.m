function A = f_generate_BA_network(n0, n, k)
% 生成无标度网络（Barabási–Albert模型）
% 输入:
%   n0 - 初始完全图的节点数
%   n  - 总节点数
%   k  - 每个新节点连接的边数
% 输出:
%   A  - 邻接矩阵 (n x n)

    if k >= n0
        error('k 必须小于初始节点数 n0');
    end
    if n <= n0
        error('总节点数 n 必须大于初始节点数 n0');
    end

    A = zeros(n);  % 初始化邻接矩阵

    % Step 1: 初始化一个 n0 节点的完全图
    for i = 1:n0
        for j = i+1:n0
            A(i,j) = 1;
            A(j,i) = 1;
        end
    end

    degree = sum(A, 2);  % 节点度数

    % Step 2: 从 n0+1 节点开始，逐个加入新节点
    for newNode = n0+1:n
        % 当前已有的节点
        existingNodes = 1:newNode-1;

        % 计算连接概率（度数归一化）
        prob = degree(existingNodes) / sum(degree(existingNodes));

        connected = false(1, newNode-1);
        edgesAdded = 0;

        while edgesAdded < k
            r = rand();
            cumProb = cumsum(prob);
            target = find(r <= cumProb, 1);

            % 避免重复连接
            if ~connected(target)
                A(newNode, target) = 1;
                A(target, newNode) = 1;
                degree(newNode) = degree(newNode) + 1;
                degree(target) = degree(target) + 1;
                connected(target) = true;
                edgesAdded = edgesAdded + 1;
            end
        end
    end
end