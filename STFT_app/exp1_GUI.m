function varargout = exp1_GUI(varargin)
% exp1_GUI M-file for exp1_GUI.fig
%      exp1_GUI, by itself, creates a new exp1_GUI or raises the existing
%      singleton*.
%
%      H = exp1_GUI returns the handle to a new exp1_GUI or the handle to
%      the existing singleton*.
%
%      exp1_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in exp1_GUI.M with the given input arguments.
%
%      exp1_GUI('Property','Value',...) creates a new exp1_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exp1_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exp1_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exp1_GUI

% Last Modified by GUIDE v2.5 14-Jun-2020 09:17:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exp1_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @exp1_GUI_OutputFcn, ...
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


% --- Executes just before exp1_GUI is made visible.
function exp1_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exp1_GUI (see VARARGIN)

% Choose default command line output for exp1_GUI
handles.output = hObject;

%handles.FSQ = (get(handles.slider2,'Value'));
%set(handles.edit1, 'String', [num2str(handles.FSQ) ''] );

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes exp1_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = exp1_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp(getappdata(test,'test_x'))
cl = questdlg('Do you want to EXIT?','EXIT',...
            'Yes','No','No');
switch cl
    case 'Yes'
        close();
        clear all;
        return;
    case 'No'
        quit cancel;
end 


% --- Executes on button press in load_file.
function load_file_Callback(hObject, eventdata, handles)
% hObject    handle to load_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    clc;
    [FileName,PathName] = uigetfile({'*.*'},'Load Wav File');
    [x,fs] = audioread([PathName '/' FileName]);
    disp(length(x))
    handles.x = x;
    handles.fs = fs;
    axes(handles.axes1);
    time = 0:1/fs:(length(handles.x)-1)/fs;
    plot(time,abs(handles.x));
    title('Original Signal');
    axes(handles.axes2);
    title('Spectrogram of Original Signal');
    [S F T P] = spectrogram(handles.x, hamming(512),256,1024, handles.fs,'yaxis');
    spectrogram(handles.x, hamming(512),256,1024, handles.fs,'yaxis');
    
guidata(hObject,handles);


% --- Executes on button press in load_random.
function load_random_Callback(hObject, eventdata, handles)
% hObject    handle to load_random (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
    tmp = randi(100,9,1);
    t = [0:0.1:1000];
    disp(t)
    x1 = tmp(1)*sin(2*pi*tmp(2).*t+tmp(3)*pi/3);
    x2 = tmp(4)*sin(2*pi*tmp(5).*t+tmp(6)*pi/5);
    x3 = tmp(7)*sin(2*pi*tmp(8).*t+tmp(9)*pi/7);
    x = x1 + x2 + x3;
    fs = 1000;
    handles.x = x;
    handles.fs = fs;
    axes(handles.axes1);
    time = 0:1/fs:(length(handles.x)-1)/fs;
    plot(abs(handles.x),t);
    title('Original Signal');
    axes(handles.axes2);
    title('Spectrogram of Original Signal');
    [S F T P] = spectrogram(handles.x, hamming(512),256,1024, handles.fs,'yaxis');
    spectrogram(handles.x, hamming(512),256,1024, handles.fs,'yaxis');    
    
guidata(hObject, handles);



