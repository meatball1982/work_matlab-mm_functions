function [min_v,max_v]=fun_find_min_max(a,b)

min_v=min([min(a(:)),min(b(:))]);
max_v=max([max(a(:)),max(b(:))]);

%% logs
% modified on : 11-Dec-2012 19:36:28
