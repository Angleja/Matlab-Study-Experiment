%%  主函数
function varargout = ElectronWave_GUI(varargin)
% ELECTRONWAVE_GUI MATLAB code for ElectronWave_GUI.fig
%      ELECTRONWAVE_GUI, by itself, creates a new ELECTRONWAVE_GUI or raises the existing
%      singleton*.
%
%      H = ELECTRONWAVE_GUI returns the handle to a new ELECTRONWAVE_GUI or the handle to
%      the existing singleton*.
%
%      ELECTRONWAVE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELECTRONWAVE_GUI.M with the given input arguments.
%
%      ELECTRONWAVE_GUI('Property','Value',...) creates a new ELECTRONWAVE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ElectronWave_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ElectronWave_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ElectronWave_GUI

% Last Modified by GUIDE v2.5 22-Apr-2019 13:49:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ElectronWave_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ElectronWave_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%% 界面启动函数
% --- Executes just before ElectronWave_GUI is made visible.
function ElectronWave_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ElectronWave_GUI (see VARARGIN)

% Choose default command line output for ElectronWave_GUI
handles.output = hObject;
handles.ElectronsColor='w';
set(handles.axes1,'color','k');
handles.AxesColor='k';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ElectronWave_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%% 输出函数
% --- Outputs from this function are returned to the command line.
function varargout = ElectronWave_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% 按钮
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 获取各个编辑文本框输入的参数
a=1e-9*str2double(get(handles.edit1,'string'));
b=1e-6*str2double(get(handles.edit2,'string'));
U=str2double(get(handles.edit3,'string'));
D=str2double(get(handles.edit4,'string'));

lamda=1.225e-9/sqrt(U*(1+9.783e-7*U)); % 电子波长
A=pi*a/(lamda*D);
B=pi*(a+b)/(lamda*D);

switch get(handles.popupmenu1,'value') % 获取弹出框中的选项
    case 1
        N=2000;
    case 2
        N=200;
    case 3
        N=20000;
    otherwise
end

% 是否选择绘制概率密度理论曲线
if get(handles.checkbox1,'value')==1 % 选中
    cla;% 清除当前坐标轴的内容，以便显示新的结果
    figure; % 创建新图形窗， 下面将其裂为 2 个子窗口，以便对比 2 个结果图
    
    subplot(2,1,2) % 在该子窗口中绘制概率密度理论曲线
    axis([-5e-5 5e-5 -4e-5 4e-5]); %设置坐标轴范围
    x=-5e-5:1e-7:5e-5;
    Pw=((sin(A*x)).^2+eps)./((A*x).^2+eps).*(cos(B*x)).^2;
    plot(x,Pw)
    title('电子双缝衍射概率密度理论分布曲线','fontsize',10,'color','k');
    xlabel('x','fontsize',10);
    ylabel('y','fontsize',10);
    hp=subplot(2,1,1); % 该子窗口用于绘制衍射图形
    axis([-5e-5 5e-5 -4e-5 4e-5]);
    xlabel('x','fontsize',10);
    ylabel('y','fontsize',10);
    title('电子双缝衍射动态随机过程的仿真','fontsize',10,'color','k');
    set(hp,'color',handles.AxesColor);
    hold on
else % 未选中，只需在界面左侧的坐标轴内绘制衍射图形
    cla % 清除当前坐标轴的内容，以便显示新的结果
    xlabel('x','fontsize',10);
    ylabel('y','fontsize',10);
    title('电子双缝衍射动态随机过程的仿真','fontsize',10,'color','k');
end

for i=1:N
    x=5e-5*(2*rand-1);
    y=4e-5*(2*rand-1); %随机产生观察点的横、纵坐标
    Pw=(sin(A*x))^2/(A*x)^2*(cos(B*x))^2; % 电子在观察点(x,y)出现的(相对)概率
    M=rand;
    if Pw>=M
        h_dot=plot(x,y,'.','markersize',10); % 在随机的落点位置(x,y)处可视化电子
        set(h_dot,'color',handles.ElectronsColor);
        % 设置电子显示色
        if N==200
            pause(0.5); % 延迟 0.5 秒， 以便实时观察动态随机过程
        end
    end
end
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

%% 可编辑文本框
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% 弹出式菜单
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 菜单
% --------------------------------------------------------------------
function Menu1_Callback(hObject, eventdata, handles)
% hObject    handle to Menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Menu2_Callback(hObject, eventdata, handles)
% hObject    handle to Menu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Menu21_Callback(hObject, eventdata, handles)
% hObject    handle to Menu21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ElectronsColor='r';
guidata(hObject,handles);

% --------------------------------------------------------------------
function Menu22_Callback(hObject, eventdata, handles)
% hObject    handle to Menu22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ElectronsColor='w';
guidata(hObject,handles);

% --------------------------------------------------------------------
function Menu11_Callback(hObject, eventdata, handles)
% hObject    handle to Menu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes1,'color','k') % 设置标识名为 axes1 的轴对象(界面左侧坐标轴)的颜色属性为黑色
handles.AxesColor='k';
guidata(hObject,handles);
% --------------------------------------------------------------------
function menu12_Callback(hObject, eventdata, handles)
% hObject    handle to menu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes1,'color','w')
handles.AxesColor='w';
guidata(hObject,handles);
%% 复选框

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
