function Local_enlarge(a,b)

fun_name = 'Local_enlarge'; % ����ɮצW��~�i�H�̳y�ۤv���ݨD�m����

%--------------------------------------------
% �C���B�� ����Ӫ��󴤧��
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
% �Ĥ@���}��
%--------------------------------------------
if isempty(strmatch(fun_name,get(gcf,'WindowButtonMotionFcn'))) % �Ĥ@���I�s~�]�w�ƹ�Ĳ�o����
    set(gcf,'WindowButtonMotionFcn',fun_name); % �N�ƹ�����Ĳ�o���� �]�� a1 �I�s�����
    set(gca,'Tag','axes1'); % �P�ɳ]�w gca �� Tag �� axes1
    set(gcf,'WindowButtonDownFcn',[fun_name '(''Do'')']); % �N�ƹ��I�� �]�w�� a1(-1)
    set(gcf,'WindowButtonUpFcn',  [fun_name '(''up'')']); 
    set(gcf,'KeyReleaseFcn',[fun_name '(''key'')'])
    set(gcf,'UserData',[0 0 0])
    return;
end

%--------------------------------------------
% �y�Ч�� �� �ഫ
%--------------------------------------------
axes1_CP  = get(handles.axes1,'CurrentPoint'); % �� axes1 �ƹ����жb 2x3
figure_CP = get(gcf,'CurrentPoint'); % �� figure �ƹ����жb 1x2
figure_si = get(gcf,'position'); % �� figure �����j�p 

axes_xy   = figure_CP ./ figure_si(3:4); % �ഫ���� 0~1 �������y��
% axes �b figure ���y�Ц�m [0 1]
% text �b figure ���y�Ц�m �H axes ���j�p�ӨM�w

Br = [];
% CP = axes1_CP;
UD = get(gcf,'UserData');
%--------------------------------------------
% ��LĲ�o���󪺧P�_
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
% WindowButtonMotionFcn Ĳ�o���󪺵{��
%--------------------------------------------
if isempty(findobj(gcf,'tag','Small_axes')) % �P�_�O�_�w�g�����Y�p�ϰ� �_
    delete(findobj(gcf,'type','text')); % �R�� �¦��� txet 
    XL = get(gca,'XLim'); % �� axes ����ɱ���
    YL = get(gca,'YLim'); % �� axes ����ɱ���
    text(axes1_CP(1,1) + 150/diff(XL)/10,axes1_CP(1,2) - 100/diff(YL)/10,'�I���Y�Ϧ�m');
    % ������ഫ���y��~�üе� txet ����
elseif any(UD(1:2)) == 0 %|| ~strcmp(a,'zero')%if (~exist('a') || a~=0) && exist('b')
        k1 = 5; % �Y�p�ϰϪ��d�� = �ƹ��y�� - k1
        k2 = 5; % �Y�p�ϰϪ��d�� = �ƹ��y�� + k1
        XL = get(handles.axes1,'XLim'); % �� axes1 ����ɱ���
        YL = get(handles.axes1,'YLim'); % �� axes1 ����ɱ���
        n = diff(YL) / diff(XL); % ������ഫ x �P y �b����Ҥj�p
        XLim_Left  = axes1_CP(1,1)-k1; % ����d��
        XLim_Right = axes1_CP(1,1)+k2; % �k��d��
        YLim_Do    = axes1_CP(1,2)-k1*n; % �U�����
        YLim_up    = axes1_CP(1,2)+k2*n; % �W�����

        set(handles.Small_axes,'XLim',[XLim_Left XLim_Right]) 
        set(handles.Small_axes,'YLim',[YLim_Do YLim_up])
        % �ܧ��Y�p�Ϫ���ɱ���~�Φ��ϧ��|�B��j���ĪG
%         if strcmp(get(handles.fill_1,'Visible'),'off')
%             set(handles.fill_1,'Visible','on')
%         end
        set(handles.axes1,'XLim',XL); % �� axes1 ����ɱ���
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
       
        Percentage = [30 30] % �Y�p�ʤ���
       
        axes_si = get(handles.axes1,'Position') % �򪺭�l�ϧΤj�p�Φ�m
        Small_axes_size = axes_si(3:4).*Percentage/100 % �Y�p�ʤ����ഫ
        
        obj_h = copyobj(handles.axes1,gcf) % �ƻs��l�ϧ�
        set(findobj(obj_h),'Visible','off') % �o�ɭԽƻs�� axes1 �P��l�����|~
                                            % �n�����ݩʹF��n�D~�]��������
        set(obj_h,'Position',[axes_xy Small_axes_size]) % �]�w�ϧΤj�p�Φ�m
        set(obj_h,'tag','Small_axes'); % �]�w �Y�p axes ��tag �� Small_axes
        set(obj_h,'FontSize',8) % �Y�p�Y�p�ϰϪ��r��j�p
        set(findobj(obj_h),'Visible','on') % �]�w���� ��������
        
        delete(findobj(gcf,'type','text')); % �b�Y�p�ϰϲ��ͦP�� �R�� text ����
        
        fill_obj = fill([1 1 2 2],[1 2 2 1],'k') % �����ͪ���~�A�h�]�w����j�p
        set(fill_obj,'tag','fill_1')
        set(fill_obj,'FaceAlpha',0) % �z���B�z
        set(fill_obj,'LineStyle',':')
        set(fill_obj,'Visible','off') % ������~

    elseif strcmp(get(gco,'tag'),'Small_axes')
        set(gcf,'WindowButtonMotionFcn',[fun_name '(''zero'')']);
        set(gcf,'UserData',[UD(1) 1 UD(3)])
    end
    
end

function BuUPFcn(fun_name,UD)
        set(gcf,'WindowButtonMotionFcn',fun_name);
        set(gcf,'UserData',[UD(1) 0 UD(3)])
end




