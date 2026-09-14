function alpha = f_alpha_risk_pref(risk_pref, p)
alpha = risk_pref;
% if p <= 0.5
%     alpha = 1 - p*(alpha + 1);
% else
%     alpha = (1 - p)*(1 - alpha);
% end
if p <= 0.5
    alpha = p*(1 - alpha);
else
    alpha = 1 - (1 - p)*(1 + alpha);
end