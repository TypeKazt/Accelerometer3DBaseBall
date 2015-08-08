
%This is the greetings GUI, which is responsible for connecting the
%accelerometer, and opening the main game GUI.

function varargout = Init_baseball_gui_(varargin)
% INIT_BASEBALL_GUI MATLAB code for Init_baseball_gui.fig
%      INIT_BASEBALL_GUI, by itself, creates a new INIT_BASEBALL_GUI or raises the existing
%      singleton*.
%
%      H = INIT_BASEBALL_GUI returns the handle to a new INIT_BASEBALL_GUI or the handle to
%      the existing singleton*.
%
%      INIT_BASEBALL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INIT_BASEBALL_GUI.M with the given input arguments.
%
%      INIT_BASEBALL_GUI('Property','Value',...) creates a new INIT_BASEBALL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Init_baseball_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Init_baseball_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Init_baseball_gui

% Last Modified by GUIDE v2.5 06-Mar-2015 16:15:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Init_baseball_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Init_baseball_gui_OutputFcn, ...
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


% --- Executes just before Init_baseball_gui is made visible.
function Init_baseball_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Init_baseball_gui (see VARARGIN)

% Choose default command line output for Init_baseball_gui
handles.output = hObject;
handles.song = audioread('song.mp3');
handles.song = audioplayer(handles.song,9600*2.25);
play(handles.song);

axes(handles.axes1)
imshow('phillies.jpg')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Init_baseball_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Init_baseball_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
stop(handles.song)
close Init_baseball_gui
baseball_game_gui

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% This button is responsible for opening the serial connection and
% callibrating the accelerometer, as well as opening the main game GUI, and
% closing itself.
