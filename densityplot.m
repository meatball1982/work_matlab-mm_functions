function densityplot(data1,data2,num_density,num_line)
%densityplot is to draw the figure that the points are colored by the density
%
%data1 is the true value (the length of data1 is better over 500)
%data2 is the analog value (the length of data2 is better over 500)
%the num_density is to control the number of color groups,better be 50 
%the num_line is the number of contour lines

%draw the regression line
k=polyfit(data1,data2,1);
y=k(1)*data1+k(2);plot(data1,y);
% eval(['equation=''y=',num2str(k(1)),'x+',num2str(k(2)),''''])
% text(min(data1),max(data2)-1,equation);
hold on

%draw y=x
xx=min(min(data1),min(data2)):0.1:max(max(data1),max(data2));
plot(xx,xx,'r-');text(min(data1),min(data1),'y=x');axis tight;axis equal;
% hold on

%calculate the density of the data,v returns a matrix containing the number of elements of that fall in each bin of the grid
[v,C]= hist3([data1(:) data2(:)],[num_density num_density]);
[m n]=meshgrid(C{1},C{2});axis tight;axis equal;

%draw contour lines,make it 5 
% [C,h]=contour(m,n,v,num_line,'k:','Linewidth',1.5,'Color','w','Linestyle','-');
% clabel(C,h);
% axis tight;axis equal;
% hold on

%draw the color of the points, the v is the color
v(v==0)=NaN;
pcolor(m,n,v);shading flat;colorbar
axis tight;axis equal;
hold off

