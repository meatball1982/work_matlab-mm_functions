function []=fun_work_li_035_myfig_out(h,fig_name,plot_n)


% set(h_axe,'FontSize',8,'FontName','Times'); %set the fontname is times and the fontsize is 8
% set(gcf,'colormap',gray,'Units','inches','Position',[5 4 3.5 3]);

% legend('boxoff');
% title(title_name);

if plot_n==3;
    img_name_eps=[fig_name,'.eps'];
    img_name_eps_sm=[fig_name,'_sm.eps'];
    
    img_name_fig=[fig_name,'.fig'];
    img_name_jpg=[fig_name,'.jpg'];
    img_name_png=[fig_name,'.png'];
    
    set(gcf, 'Color', 'w')
    exportfig(gcf,img_name_eps,'color','cmyk');
    saveas(gcf,img_name_fig,'fig');    
    set(gcf, 'Color', 'w')
    export_fig(img_name_jpg,gcf,'-zbuffer','-jpg','-CMYK');
    title(' ')
    legend off
    set(gcf, 'Color', 'w')
    set(gca,'FontSize',14)
    export_fig(img_name_png,gcf,'-png','-zbuffer','-CMYK','-q30','-r200');% mod : 16-Sep-2014 15:39:51
    exportfig(gcf,img_name_eps_sm,'color','cmyk','FontSize',1.5,'LineMode','scaled','LineWidth',1.0,'height',3.5);
    
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
% mod : 30-Jul-2013 16:58:25
% 
% mod : 15-Jul-2013 10:26:26
% add the sm eps store and png store.
