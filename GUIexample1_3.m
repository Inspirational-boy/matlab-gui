function GUIexample1
close all;
global GUI      %方便参数传递
global EditValue1
global EditValue2
global num
global flag1
global flag2
flag1=0;
flag2=0;

GUI.h=figure('units','pixels',...
    'position',[10 550 450 250],...
    'menubar','none',...
    'name','抽奖机',... 
    'numbertitle','off',...
    'resize','off');

InterfacePic=imread('InterfacePic.png');
fac_pic=3.1;
axes('Parent',GUI.h,'Position',[0.28,0.05,0.296*fac_pic,0.28*fac_pic])
imshow(InterfacePic)

StrtIcon=imread('StrtIcon.png');
StrtIcon=imresize(StrtIcon,[140,38]);
GUI.Strt=uicontrol('Parent',GUI.h,'Style','Pushbutton','string','',...
    'Position',[410 57 38 140],'callback',@CountStart,...
    'CData',StrtIcon,'visible','on');

StopIcon=imread('StopIcon.png');
StopIcon=imresize(StopIcon,[140,38]);
GUI.Stop=uicontrol('Parent',GUI.h,'Style','Pushbutton','string','',...
    'Position',[410 57 38 140],'callback',@CountStop,...
    'CData',StopIcon,'visible','off');

GUI.buttton=uicontrol('Parent',GUI.h,'Style','pushbutton','String','Reset',...
    'Position',[140 197 50 30],'visible','on','BackgroundColor','r',...
    'ForegroundColor','w','Fontsize',12,'callback',@Reset);
%Parent 父集、子集，在多界面中作用明显
%Style 定义类型，这里是一个按钮
%String 显示的名称
%Position 控件显示的位置，大小
%visible 控件是否可见

GUI.text1=uicontrol('Parent',GUI.h,'Style','text','String','RESET:',...
    'Position',[10 197 125 22],'Fontsize',12,'FontWeight','bold',...
    'HorizontalAlignment','left');

GUI.text2=uicontrol('Parent',GUI.h,'Style','text','String','Total Number:',...
    'Position',[10 160 125 22],'Fontsize',12,'FontWeight','bold',...
    'HorizontalAlignment','left');

GUI.text3=uicontrol('Parent',GUI.h,'Style','text','String','Number of winners:',...
    'Position',[10 123 151,22],'Fontsize',12,'FontWeight','bold',...
    'HorizontalAlignment','left');

GUI.tip=uicontrol('Parent',GUI.h,'Style','Text','string',...
    'Tip:Total Number cannot be less than Number of winners',...
    'Position',[10 47 204 37],'Fontsize',11,'FontWeight','bold',...
    'HorizontalAlignment','left','ForegroundColor','r');

GUI.edit1=uicontrol('Parent',GUI.h,'Style','edit','String','10',...
    'Position',[140 157 50 30],'Fontsize',12,'FontWeight','bold',...
    'visible','on','callback',@ChangeEditFun1);
EditValue1=get(GUI.edit1,'string');     %读取edit1初始值
num = [1:str2double(EditValue1)];

GUI.edit2=uicontrol('Parent',GUI.h,'Style','edit','String','3',...
    'Position',[165 117 50 30],'Fontsize',12,'FontWeight','bold',...
    'callback',@ChangeEditFun2);
EditValue2=get(GUI.edit2,'string');     %读取eedit2初始值

% 抽奖机显示的五个数字
GUI.Result1=uicontrol('Parent',GUI.h,'Style','Text','string','',...
    'Position',[258 170 133 21],'Fontsize',12,'FontWeight','bold',...
    'HorizontalAlignment','center');

GUI.Result2=uicontrol('Parent',GUI.h,'Style','Text','string','',...
    'Position',[258 150 133 21],'Fontsize',12,'FontWeight','bold',...
    'HorizontalAlignment','center');

GUI.Result3=uicontrol('Parent',GUI.h,'Style','Text','string','Ready',...
    'Position',[258 130 133 21],'Fontsize',12,'FontWeight','bold',...
    'HorizontalAlignment','center');

GUI.Result4=uicontrol('Parent',GUI.h,'Style','Text','string','',...
    'Position',[258 110 133 21],'Fontsize',12,'FontWeight','bold',...
    'HorizontalAlignment','center');

GUI.Result5=uicontrol('Parent',GUI.h,'Style','Text','string','',...
    'Position',[258 90 133 21],'Fontsize',12,'FontWeight','bold',...
    'HorizontalAlignment','center');

end

% callback事件函数
% 读取键入的edit1值
function ChangeEditFun1(~,~)
global GUI
global EditValue1
global flag1
if str2double(get(GUI.edit1,'string'))~=str2double(EditValue1)
    flag1=1;
else
    flag1=0;
end
EditValue1=get(GUI.edit1,'string');       %get 查询特定对象的特定属性
end

% 读取键入的edit2值
function ChangeEditFun2(~,~)
global GUI
global EditValue2
global flag2
if str2double(get(GUI.edit2,'string'))~=str2double(EditValue2)
    flag2=1;
else
    flag2=0;
end
EditValue2=get(GUI.edit2,'string');       %get 查询特定对象的特定属性
end

function Reset(~,~)
global GUI
global EditValue1
global EditValue2
global num
set(GUI.edit1,'String','10')
EditValue1=get(GUI.edit1,'string')
num = [1:str2double(EditValue1)];
set(GUI.edit2,'String','3')
EditValue2=get(GUI.edit2,'string')
set(GUI.Result1,'String','')
set(GUI.Result2,'String','')
set(GUI.Result3,'BackgroundColor',[0.94,0.94,0.94],'String','Ready')
set(GUI.Result4,'String','')
set(GUI.Result5,'String','')
end

function CountStart(~,~)
global GUI
global EditValue1
global EditValue2
global flag1
global flag2
global num
set(GUI.Result3,'BackgroundColor',[0.80,0.80,0.80])
if EditValue2==0
        set(GUI.Strt,'visible','on')
        set(GUI.Stop,'visible','off')
        while 1
            pause(1)
            if EditValue2>0
                break;
            end
        end
elseif EditValue2>0
    set(GUI.Strt,'visible','off')
    set(GUI.Stop,'visible','on')
while 1
     if flag1 | flag2
         flag1=0;
         flag2=0;
         num = [1:str2double(EditValue1)];
     end
     if numel(num)>4
     n=5;           %选中5个数显示
     random_num = num(randperm(numel(num),n));
     set(GUI.Result1,'string',num2str(random_num(1)));
     set(GUI.Result2,'string',num2str(random_num(2)));
     set(GUI.Result3,'string',num2str(random_num(3)));
     set(GUI.Result4,'string',num2str(random_num(4)));
     set(GUI.Result5,'string',num2str(random_num(5)));
     pause(0.05);
     elseif numel(num)==4
         n=4;           %选中5个数显示
     random_num = num(randperm(numel(num),n));
     set(GUI.Result1,'string','');
     set(GUI.Result2,'string',num2str(random_num(1)));
     set(GUI.Result3,'string',num2str(random_num(2)));
     set(GUI.Result4,'string',num2str(random_num(3)));
     set(GUI.Result5,'string',num2str(random_num(4)));
     pause(0.05);
     elseif numel(num)==3
             n=3;           %选中5个数显示
     random_num = num(randperm(numel(num),n));
     set(GUI.Result2,'string',num2str(random_num(1)));
     set(GUI.Result3,'string',num2str(random_num(2)));
     set(GUI.Result4,'string',num2str(random_num(3)));
     set(GUI.Result5,'string','');
     pause(0.05);
     elseif numel(num)==2
             n=2;           %选中5个数显示
     random_num = num(randperm(numel(num),n));
     set(GUI.Result2,'string',num2str(random_num(1)));
     set(GUI.Result3,'string',num2str(random_num(2)));
     set(GUI.Result4,'string','');
     pause(0.05);
     elseif numel(num)==1
         n=1;           %选中5个数显示
     random_num = num(randperm(numel(num),n));
     set(GUI.Result2,'string','');
     set(GUI.Result3,'string',num2str(random_num(1)));
     pause(0.05);
     elseif numel(num)==0
         set(GUI.Result3,'string',num2str(num));
         pause(0.05);
     end
     if length(get(GUI.Strt,'visible'))==2
         break;
     end
end
num1=str2double(get(GUI.Result3,'string'));
num=setxor(num,num1)
end
end

function CountStop(~,~)
global GUI
global EditValue2
set(GUI.Strt,'visible','on')
set(GUI.Stop,'visible','off')
EditValue2=str2double(get(GUI.edit2,'string'));
EditValue2=EditValue2-1;
set(GUI.edit2,'string',num2str(EditValue2));
end
