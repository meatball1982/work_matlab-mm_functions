function [time_str]=fun_mm_time_str(n)
% [time_str]=fun_mm_time_str(n)
% get the n part of the time string.
% mod : 17-Aug-2013 15:09:47

ti=datevec(now);

time_str=['_'];
for i=1:(n-1)
    time_str=[time_str,mat2str(ti(i)),'_'];
end
time_str=[time_str,mat2str(ti(n))];