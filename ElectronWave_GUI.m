%%  ������
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

%% ������������
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

%% �������
% --- Outputs from this function are returned to the command line.
function varargout = ElectronWave_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% ��ť
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ��ȡ�����༭�ı�������Ĳ���
a=1e-9*str2double(get(handles.edit1,'string'));
b=1e-6*str2double(get(handles.edit2,'string'));
U=str2double(get(handles.edit3,'string'));
D=str2double(get(handles.edit4,'string'));

lamda=1.225e-9/sqrt(U*(1+9.783e-7*U)); % ���Ӳ���
A=pi*a/(lamda*D);
B=pi*(a+b)/(lamda*D);

switch get(handles.popupmenu1,'value') % ��ȡ�������е�ѡ��
    case 1
        N=2000;
    case 2
        N=200;
    case 3
        N=20000;
    otherwise
end

% �Ƿ�ѡ����Ƹ����ܶ���������
if get(handles.checkbox1,'value')==1 % ѡ��
    cla;% �����ǰ����������ݣ��Ա���ʾ�µĽ��
    figure; % ������ͼ�δ��� ���潫����Ϊ 2 ���Ӵ��ڣ��Ա�Ա� 2 �����ͼ
    
    subplot(2,1,2) % �ڸ��Ӵ����л��Ƹ����ܶ���������
    axis([-5e-5 5e-5 -4e-5 4e-5]); %���������᷶Χ
    x=-5e-5:1e-7:5e-5;
    Pw=((sin(A*x)).^2+eps)./((A*x).^2+eps).*(cos(B*x)).^2;
    plot(x,Pw)
    title('����˫����������ܶ����۷ֲ�����','fontsize',10,'color','k');
    xlabel('x','fontsize',10);
    ylabel('y','fontsize',10);
    hp=subplot(2,1,1); % ���Ӵ������ڻ�������ͼ��
    axis([-5e-5 5e-5 -4e-5 4e-5]);
    xlabel('x','fontsize',10);
    ylabel('y','fontsize',10);
    title('����˫�����䶯̬������̵ķ���','fontsize',10,'color','k');
    set(hp,'color',handles.AxesColor);
    hold on
else % δѡ�У�ֻ���ڽ��������������ڻ�������ͼ��
    cla % �����ǰ����������ݣ��Ա���ʾ�µĽ��
    xlabel('x','fontsize',10);
    ylabel('y','fontsize',10);
    title('����˫�����䶯̬������̵ķ���','fontsize',10,'color','k');
end

for i=1:N
    x=5e-5*(2*rand-1);
    y=4e-5*(2*rand-1); %��������۲��ĺᡢ������
    Pw=(sin(A*x))^2/(A*x)^2*(cos(B*x))^2; % �����ڹ۲��(x,y)���ֵ�(���)����
    M=rand;
    if Pw>=M
        h_dot=plot(x,y,'.','markersize',10); % ����������λ��(x,y)�����ӻ�����
        set(h_dot,'color',handles.ElectronsColor);
        % ���õ�����ʾɫ
        if N==200
            pause(0.5); % �ӳ� 0.5 �룬 �Ա�ʵʱ�۲춯̬�������
        end
    end
end
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

%% �ɱ༭�ı���
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

%% ����ʽ�˵�
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
%% �˵�
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
set(handles.axes1,'color','k') % ���ñ�ʶ��Ϊ axes1 �������(�������������)����ɫ����Ϊ��ɫ
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
%% ��ѡ��

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
