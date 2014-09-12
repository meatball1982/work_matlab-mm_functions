function Local_enlarge(a,b)

fun_name = 'Local_enlarge'; % 函數檔案名稱~可以依造自己的需求置換掉

%--------------------------------------------
% 每次運行 抓取個物件握把值
%--------------------------------------------
if ~isempty(findobj(0,'type','figure'))
    handles.Small_axes = findobj(gcf,'tag','Small_axes');
    handles.axes1      = findobj(gcf,'tag','axes1');
    handles.text       = findobj(gcf,'tag','text1');
    handles.fill_1     = findobj(gcf,'tag','fill_1');
else
    return;
end

%--------------------------------------------
% 第一次開啟
%--------------------------------------------
if isempty(strmatch(fun_name,get(gcf,'WindowButtonMotionFcn'))) % 第一次呼叫~設定滑鼠觸發條件
    set(gcf,'WindowButtonMotionFcn',fun_name); % 將滑鼠移動觸發條件 設為 a1 呼叫此函數
    set(gca,'Tag','axes1'); % 同時設定 gca 的 Tag 為 axes1
    set(gcf,'WindowButtonDownFcn',[fun_name '(''Do'')']); % 將滑鼠點擊 設定為 a1(-1)
    set(gcf,'WindowButtonUpFcn',  [fun_name '(''up'')']); 
    set(gcf,'KeyReleaseFcn',[fun_name '(''key'')'])
    set(gcf,'UserData',[0 0 0])
    return;
end

%--------------------------------------------
% 座標抓取 及 轉換
%--------------------------------------------
axes1_CP  = get(handles.axes1,'CurrentPoint'); % 獲的 axes1 滑鼠坐標軸 2x3
figure_CP = get(gcf,'CurrentPoint'); % 獲的 figure 滑鼠坐標軸 1x2
figure_si = get(gcf,'position'); % 獲的 figure 視窗大小 

axes_xy   = figure_CP ./ figure_si(3:4); % 轉換介於 0~1 之間的座標
% axes 在 figure 的座標位置 [0 1]
% text 在 figure 的座標位置 以 axes 的大小來決定

Br = [];
% CP = axes1_CP;
UD = get(gcf,'UserData');
%--------------------------------------------
% 其他觸發條件的判斷
%--------------------------------------------
if ~exist('a')
    a = false;
end
switch a
    case 'zero'
        Small_axes_Pi = get(handles.Small_axes,'Position');
        qq = get(handles.Small_axes,'CurrentPoint');
        ww = [get(handles.Small_axes,'XLim') get(handles.Small_axes,'YLim')];
        hh = [diff(ww(1:2)) diff(ww(3:4))];
        hh = Small_axes_Pi(3:4) ./hh.* [qq(1,1)-ww(1) qq(1,2)-ww(3)];
        set(handles.Small_axes,'Position',[axes_xy Small_axes_Pi(3:4)])
    case 'up'
        BuUPFcn(fun_name,UD)
    case 'Do'
        BuDoFcn(handles,axes_xy,figure_si,fun_name,UD)
    case 'key'

        keyobj(fun_name,UD)
    otherwise
end

%--------------------------------------------
% WindowButtonMotionFcn 觸發條件的程序
%--------------------------------------------
if isempty(findobj(gcf,'tag','Small_axes')) % 判斷是否已經產生縮小圖區 否
    delete(findobj(gcf,'type','text')); % 刪除 舊有的 txet 
    XL = get(gca,'XLim'); % 獲的 axes 的邊界條件
    YL = get(gca,'YLim'); % 獲的 axes 的邊界條件
    text(axes1_CP(1,1) + 150/diff(XL)/10,axes1_CP(1,2) - 100/diff(YL)/10,'點擊縮圖位置');
    % 等比例轉換為座標~並標註 txet 物件
elseif any(UD(1:2)) == 0 %|| ~strcmp(a,'zero')%if (~exist('a') || a~=0) && exist('b')
        k1 = 5; % 縮小圖區的範圍 = 滑鼠座標 - k1
        k2 = 5; % 縮小圖區的範圍 = 滑鼠座標 + k1
        XL = get(handles.axes1,'XLim'); % 獲的 axes1 的邊界條件
        YL = get(handles.axes1,'YLim'); % 獲的 axes1 的邊界條件
        n = diff(YL) / diff(XL); % 等比例轉換 x 與 y 軸的比例大小
        XLim_Left  = axes1_CP(1,1)-k1; % 左邊範圍
        XLim_Right = axes1_CP(1,1)+k2; % 右邊範圍
        YLim_Do    = axes1_CP(1,2)-k1*n; % 下面邊界
        YLim_up    = axes1_CP(1,2)+k2*n; % 上面邊界

        set(handles.Small_axes,'XLim',[XLim_Left XLim_Right]) 
        set(handles.Small_axes,'YLim',[YLim_Do YLim_up])
        % 變更縮小圖的邊界條件~形成圖形舉步放大的效果
%         if strcmp(get(handles.fill_1,'Visible'),'off')
%             set(handles.fill_1,'Visible','on')
%         end
        set(handles.axes1,'XLim',XL); % 獲的 axes1 的邊界條件
        set(handles.axes1,'YLim',YL);
        set(handles.fill_1,'XData',[XLim_Left XLim_Left XLim_Right XLim_Right])
        set(handles.fill_1,'YData',[YLim_Do YLim_up YLim_up YLim_Do])
        
end
        if UD(3) == 1
            set(handles.fill_1,'Visible','off')
        else
            set(handles.fill_1,'Visible','on')
        end

end

function keyobj(fun_name,UD)

    if strcmp('space',get(gcf,'CurrentKey'))
        if UD(1) == 0
            set(gcf,'UserData',[1 UD(2:3)])
        else
            set(gcf,'UserData',[0 UD(2:3)])
        end
    elseif strcmp('control',get(gcf,'CurrentKey'))
        if UD(3) == 0
            set(gcf,'UserData',[UD(1:2) 1])
        else
            set(gcf,'UserData',[UD(1:2) 0])
        end
    end

end

function BuDoFcn(handles,axes_xy,figure_si,fun_name,UD)
    
    if isempty(findobj(gcf,'tag','Small_axes'))
       
        Percentage = [30 30] % 縮小百分比
       
        axes_si = get(handles.axes1,'Position') % 獲的原始圖形大小及位置
        Small_axes_size = axes_si(3:4).*Percentage/100 % 縮小百分比轉換
        
        obj_h = copyobj(handles.axes1,gcf) % 複製原始圖形
        set(findobj(obj_h),'Visible','off') % 這時候複製的 axes1 與原始的重疊~
                                            % 要改變屬性達到要求~因此先隱藏
        set(obj_h,'Position',[axes_xy Small_axes_size]) % 設定圖形大小及位置
        set(obj_h,'tag','Small_axes'); % 設定 縮小 axes 的tag 為 Small_axes
        set(obj_h,'FontSize',8) % 縮小縮小圖區的字體大小
        set(findobj(obj_h),'Visible','on') % 設定完成 取消隱藏
        
        delete(findobj(gcf,'type','text')); % 在縮小圖區產生同時 刪除 text 物件
        
        fill_obj = fill([1 1 2 2],[1 2 2 1],'k') % 先產生物件~再去設定物件大小
        set(fill_obj,'tag','fill_1')
        set(fill_obj,'FaceAlpha',0) % 透明處理
        set(fill_obj,'LineStyle',':')
        set(fill_obj,'Visible','off') % 先隱藏~

    elseif strcmp(get(gco,'tag'),'Small_axes')
        set(gcf,'WindowButtonMotionFcn',[fun_name '(''zero'')']);
        set(gcf,'UserData',[UD(1) 1 UD(3)])
    end
    
end

function BuUPFcn(fun_name,UD)
        set(gcf,'WindowButtonMotionFcn',fun_name);
        set(gcf,'UserData',[UD(1) 0 UD(3)])
end




