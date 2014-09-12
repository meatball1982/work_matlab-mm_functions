function [ hist_2d ] = fun_plot_res_den( re, si , num_den )
% [ hist_2d ] = fun_plot_res_den( re, si , num_den )
% this function is to plot the density of re and si
% input ----------------------------- 
% re      : real data
% si      : simulation data
% num_den : hist number 
% output ----------------------------
% hist_2d : mat2d , hist density
% 



%% main part
% low and up bound
dat=[re'; si']';
mi=min(dat(:));
mx=max(dat(:));

% hist boundary
x_hi=linspace(mi,mx,num_den);

% hist process
histmat  = hist2(re, si, x_hi, x_hi);

% 4 var output
hist_2d = histmat;

% 4 figure output
[X,Y]=meshgrid(x_hi,x_hi);

histmat(histmat==0)=NaN;
pcolor(X',Y',histmat)
shading flat
axis equal
axis([mi mx mi mx])
% colorbar
hold on
line([mi mx],[mi mx],'LineWidth',2,'Color',[0 0 0])
grid on
% title(str)

% ind=(histmat==1);
% x_1=X(ind);
% y_1=Y(ind);
% plot(y_1,x_1,'r.')


end

%% logs
% mod : 23-Apr-2014 09:39:00
% add title str.
%
% mod : 21-Apr-2014 18:55:27
% 



