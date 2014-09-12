function []=fun_work_li_035_myfig_out(h,fig_name,plot_n)


% set(h_axe,'FontSize',8,'FontName','Times'); %set the fontname is times and the fontsize is 8
% set(gcf,'colormap',gray,'Units','inches','Position',[5 4 3.5 3]);

% legend('boxoff');
% title(title_name);

if plot_n==3;
    img_name_eps=[fig_name,'.eps'];
    img_name_jpg=[fig_name,'.jpeg'];
    img_name_fig=[fig_name,'.fig'];
    
    saveas(gcf,img_name_fig,'fig');
    exportfig(gcf,img_name_eps,'color','cmyk');
    % print(gcf,'-djpeg',img_name_jpg)
    exportfig(gcf,img_name_jpg, 'Format','jpeg','fontmode','fixed', 'fontsize',8,'preview','tiff','color','cmyk');
else
    img_name_eps=[fig_name,'.eps'];
%     img_name_jpg=[fig_name,'.jpeg'];
    img_name_fig=[fig_name,'.fig'];
    
    saveas(gcf,img_name_fig,'fig');
    exportfig(gcf,img_name_eps,'color','cmyk');
%     print(gcf,'-djpeg',img_name_jpg)
    
    % exportfig(gcf,img_name_jpg, 'Format','jpeg','fontmode','fixed', 'fontsize',8,'preview','tiff','color','cmyk');
end
    
% 