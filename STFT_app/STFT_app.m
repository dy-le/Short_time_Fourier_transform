function varargout = STFT_app(varargin)
% STFT_APP MATLAB code for STFT_app.fig
%      STFT_APP, by itself, creates a new STFT_APP or raises the existing
%      singleton*.
%
%      H = STFT_APP returns the handle to a new STFT_APP or the handle to
%      the existing singleton*.
%
%      STFT_APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STFT_APP.M with the given input arguments.
%
%      STFT_APP('Property','Value',...) creates a new STFT_APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before STFT_app_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to STFT_app_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help STFT_app

% Last Modified by GUIDE v2.5 16-Jun-2020 23:19:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @STFT_app_OpeningFcn, ...
                   'gui_OutputFcn',  @STFT_app_OutputFcn, ...
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


% --- Executes just before STFT_app is made visible.
function STFT_app_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to STFT_app (see VARARGIN)

% Choose default command line output for STFT_app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes STFT_app wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = STFT_app_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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
    Fs = 1000;            % Sampling frequency                    
    T = 1/Fs;             % Sampling period       
    L = 1500;             % Length of signal
    t = (0:L-1)*T;        % Time vector
    tmp = randi(100,9,1);
    t1 = t;
    t1()
    x1 = tmp(1)*sin(2*pi*tmp(2).*t+tmp(3));
    x2 = tmp(4)*sin(2*pi*tmp(5)*5.*t+tmp(6)*pi/5);
    x3 = tmp(7)*sin(2*pi*tmp(8)*10.*t+tmp(9)*pi/7);
    x = x1 + x2 + x3;
    
%     x1 = rand() * sin(2*pi*(randi(100)+30)*t);
%     temp = zeros(1, L);
%     t1 = randi(1200);
%     t2 = randi(1500 - t1) + t1;
%     temp(t1:t2) = 1;
%     x1 = temp.*x1;
%     x2 = rand() * sin(2*pi*(randi(100)+30)*t);
%     temp = zeros(1, L);
%     t1 = randi(1200);
%     t2 = randi(1500 - t1) + t1;
%     temp(t1:t2) = 1;
%     x2 = temp.*x2;
%     x3 = rand() * sin(2*pi*(randi(100)+30)*t);
%     temp = zeros(1, L);
%     t1 = randi(1200);
%     t2 = randi(1500 - t1) + t1;
%     temp(t1:t2) = 1;
%     x3 = temp.*x3;
%     x = x1 + x2 + x3;
    
    fs = 1500;
    handles.x = x;
    handles.fs = fs;
    axes(handles.axes1);
    time = 0:1/fs:(length(handles.x)-1)/fs;
    plot(t,handles.x);
    title('Original Signal');
    axes(handles.axes2);
    title('Spectrogram of Original Signal');
    %[S F T P] = spectrogram(handles.x, hamming(512),256,1024, handles.fs,'yaxis');
    spectrogram(handles.x, hamming(512),128,1024, handles.fs,'yaxis');    
guidata(hObject, handles);
