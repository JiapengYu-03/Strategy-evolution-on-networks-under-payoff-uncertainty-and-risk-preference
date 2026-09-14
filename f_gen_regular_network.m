function A = f_gen_regular_network(n, k)
    % 验证合法性
    if mod(n * k, 2) ~= 0
        error('n * k must be even.');
    end
    if k >= n
        error('k must be less than n.');
    end

    max_tries = 1000;
    for attempt = 1:max_tries
        % 创建重复的节点列表，每个节点重复 k 次
        stubs = repelem(1:n, k);
        stubs = stubs(randperm(length(stubs)));  % 随机打乱

        A = zeros(n);
        valid = true;

        for i = 1:2:length(stubs)
            u = stubs(i);
            v = stubs(i+1);

            % 拒绝自环和多重边
            if u == v || A(u, v) == 1
                valid = false;
                break;
            end

            A(u, v) = 1;
            A(v, u) = 1;
        end

        if valid
            return;
        end
    end

    error('Failed to generate a simple random k-regular graph after many tries.');
end