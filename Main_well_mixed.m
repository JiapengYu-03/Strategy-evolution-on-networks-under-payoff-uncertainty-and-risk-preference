% Basic parameters
n = 7;
p = 0.5;
Q = 0;
B = 0.2;
risk_pref_n = 0.5;

% Generate the graph
mat = f_generate_well_mixed(n);
disp(mat);

% Calculate reproductive values
repro_val = sum(mat) / sum(sum(mat));

% Calculate the transition matrix
trans_mat = f_gen_trans_mat(mat,n);

% Calculate remeeting times
retime2 = f_cal_remeet_time_two(trans_mat, n);
retime3 = f_cal_remeet_time_three(trans_mat, retime2, n);
retime4 = f_cal_remeet_time_four(trans_mat, retime2, retime3, n);

% Assign the same risk preference to all nodes
risk_pref = zeros(1,n) + risk_pref_n;
alpha = f_alpha_risk_pref(risk_pref,p);

% Calculate the critical benefit-to-cost ratio
bcratio = f_get_bcratio_average( ...
    trans_mat, repro_val, n, retime2, retime3, retime4, ...
    Q, p, B, alpha);

disp(bcratio)