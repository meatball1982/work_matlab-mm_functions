function []=fun_work_li_035_myfig_out(h,fig_name,plot_n)


% set(h_axe,'FontSize',8,'FontName','Times'); %set the fontname is times and the fontsize is 8
% set(gcf,'colormap',gray,'Units','inches','Position',[5 4 3.5 3]);

% legend('boxoff');
% title(title_name);

if plot_n==3;
    img_name_eps=[fig_name,'.eps'];
    img_name_eps_sm=[fig_name,'_sm.eps'];
    img_name_jpg=[fig_name,'.jpeg'];
    img_name_fig=[fig_name,'.fig'];
    img_name_png=[fig_name,'.png'];
    
    saveas(gcf,img_name_fig,'fig');
    exportfig(gcf,img_name_eps,'color','cmyk');
    exportfig(gcf,img_name_eps_sm,'color','cmyk','FontSize',1.5,'LineMode','scaled','LineWidth',1.0,'height',3.5);
    exportfig(gcf,img_name_png,'Format','png','color','cmyk',...
        'FontSize',1.5,'LineMode','scaled','LineWidth',1.3,'height',4);
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
    
%% logs
% mod : 15-Jul-2013 10:26:26
% add the sm eps store and png store.
