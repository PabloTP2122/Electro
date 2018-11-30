function varargout = Electro1(varargin)
% ELECTRO1 MATLAB code for Electro1.fig
%      ELECTRO1, by itself, creates a new ELECTRO1 or raises the existing
%      singleton*.
%
%      H = ELECTRO1 returns the handle to a new ELECTRO1 or the handle to
%      the existing singleton*.
%
%      ELECTRO1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELECTRO1.M with the given input arguments.
%
%      ELECTRO1('Property','Value',...) creates a new ELECTRO1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Electro1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Electro1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Electro1

% Last Modified by GUIDE v2.5 20-Nov-2018 20:22:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Electro1_OpeningFcn, ...
                   'gui_OutputFcn',  @Electro1_OutputFcn, ...
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


% --- Executes just before Electro1 is made visible.
function Electro1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Electro1 (see VARARGIN)

%Variables iniciales de programa


%Variables iniciales de programa
global a t
a = arduino('COM5');
T = 50;
passo = 1;
t=0;
x=0;
L = imread('E3.png');

handles.axes3 = imshow(L);

% Choose default command line output for Electro1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Electro1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Electro1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a
axes(handles.axes1)

minutosDeEj = 30;
%Leer valores

%%Visualización
salida=0;
h = animatedline('Color',' b', 'LineWidth', 2);
ylim([handles.Ymin handles.Ymax])
%xlabel('TIEMPO');
%ylabel('Voltaje');
ax = gca;
startTime = datetime('now');
grid on
while 1 
   v = readVoltage(a, 'A0');
   salida=v*1;
   t = datetime('now') - startTime;
   addpoints(h,datenum(t),salida);
   ax.XLim = datenum([t-seconds(15) t]); 
   drawnow
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
handles.dato1=get(hObject,'string');
handles.Ymax=str2double(handles.dato1);

guidata(hObject, handles);


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

handles.dato2=get(hObject,'string');
handles.Ymin=str2double(handles.dato2);


guidata(hObject, handles);

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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(ax)
