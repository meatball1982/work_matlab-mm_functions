function [h]=fun_plot_res_sqr(re,si,ti)
% [h]=fun_plot_res_sqr(re,si,ti)
% mod : 27-Feb-2013 13:41:13

[min_v,max_v]=fun_find_min_max(re,si);

h=plot(re,si,'o','Markersize',4,'MarkerFaceColor','b');
title(ti);
axis equal
hold on
line([min_v max_v],[min_v,max_v],'LineWidth',2,'Color',[0 0 0]);
axis([min_v max_v min_v max_v]);
grid on;
% xlabel(['test real ',ti(1:2)]);
% ylabel(['test sim  ',ti(1:2)]);