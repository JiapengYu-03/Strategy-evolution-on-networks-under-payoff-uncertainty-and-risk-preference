function A = f_generate_star(n)
    % 计算节点总数
    num_nodes = n + 1;
    
    % 初始化邻接矩阵
    A = zeros(num_nodes);
    
    % 连接星的中心（节点1）到 n 个叶子节点
    for i = 1:n
        A(1, i+1) = 1;  % 中心节点与叶子节点相连
        A(i+1, 1) = 1;  % 叶子节点与中心节点相连
    end

end