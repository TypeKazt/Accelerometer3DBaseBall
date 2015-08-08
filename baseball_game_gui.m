% This is the main GUI for our application which holds the game itself,
% certain stats about the ball and player, and an options button.


function varargout = baseball_game_gui(varargin)
% BASEBALL_GAME_GUI MATLAB code for baseball_game_gui.fig
%      BASEBALL_GAME_GUI, by itself, creates a new BASEBALL_GAME_GUI or raises the existing
%      singleton*.
%
%      H = BASEBALL_GAME_GUI returns the handle to a new BASEBALL_GAME_GUI or the handle to
%      the existing singleton*.
%
%      BASEBALL_GAME_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASEBALL_GAME_GUI.M with the given input arguments.
%
%      BASEBALL_GAME_GUI('Property','Value',...) creates a new BASEBALL_GAME_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before baseball_game_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to baseball_game_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help baseball_game_gui

% Last Modified by GUIDE v2.5 10-Mar-2015 13:10:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @baseball_game_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @baseball_game_gui_OutputFcn, ...
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


% --- Executes just before baseball_game_gui is made visible.
function baseball_game_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to baseball_game_gui (see VARARGIN)

% Choose default command line output for baseball_game_gui
handles.output = hObject;
macVpc = ismac; %The checks whether the computer is a mac.

% This code automatically finds the correct comPort if the computer is a PC
% else it prompts for the user to input the appropriate COM Port.

if macVpc == 0;
    try
        [~,res]=system('mode');
        ix = strfind(res,'COM');
        port = regexp(res,'COM\d+','match');
        handles.comPort = port{1:1};
    catch exception
        if ~isempty(instrfind)
            fclose(instrfind);
            delete(instrfind);
        end
        close all
        clc
    end
elseif macVpc == 1;
    prompt = {'Enter the COM Port associated with your Arduino:'};
    dlg_title = 'Input';
    num_lines = 1;
    answer = inputdlg(prompt,dlg_title,num_lines);
    handles.comPort = answer{1:1};
end

% 2. Initialize the Serial Port - setupSerial() (not to be altered)

%connect MATLAB to the accelerometer
if (~exist('handles.serialFlag','var'))
[handles.accelerometer.s, handles.serialFlag]=setupSerial(handles.comPort);
end

%This checks for the calibration save file associated with the
%accelerometer and if it doesn't exist creates one.
if exist('CalDataSAC.mat', 'file') == 2
    A = load('CalDataSAC.mat');
    handles.calCo.g = A.calibrationsave.g;
    handles.calCo.offset = A.calibrationsave.offset;
    guidata(hObject, handles);
else
    handles.calCo = calibrate(handles.accelerometer.s);
    calibrationsave = calCo;
    save('CalDataSAC.mat','calibrationsave')
    guidata(hObject, handles);
end


[num, txt] = xlsread('highScoresSAC.xlsx');

highSpeed = readHighScoreSpeed(num,txt);
highSwing = readHighScoreSwing(num,txt);
highDistance = readHighScoreDistance(num,txt);

set(handles.userNameHighSpeed, 'String',highSpeed(1,1));
set(handles.userNameHighDist, 'String',highDistance(1,1));
set(handles.userNameHighSwing, 'String',highSwing(1,1));
set(handles.ballSpeedHigh, 'String',highSpeed(1,2));
set(handles.ballDistanceHigh, 'String',highDistance(1,2));
set(handles.swingForceHigh, 'String',highSwing(1,2));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes baseball_game_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = baseball_game_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in options_btn.
function options_btn_Callback(hObject, eventdata, handles)
% hObject    handle to options_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (strcmp(get(handles.play_ball, 'String'), 'Play Ball!'))
    options_gui
end
% opens a menu for options responsible for altering game constants


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)'
closeSerial;
clear all
close all
clc


% --- Executes on button press in play_ball.
function play_ball_Callback(hObject, eventdata, handles)
% hObject    handle to play_ball (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.play_ball, 'String', 'Running...');

if(isempty(getappdata(0,'BallSpeed')) == 1)
    ballSpeed = 2;
else
    ballSpeed = getappdata(0,'BallSpeed');
end

if(isempty(getappdata(0,'Gravity')) == 1)
    gravity = 9.81;
else
    gravity = getappdata(0,'Gravity');
end

if(isempty(getappdata(0,'UserName')) == 1)
    userName = 'Anonymous';
else
    userName = getappdata(0,'UserName');
end

hold on

[num, txt] = xlsread('highScoresSAC.xlsx');
h = size(num,1) + 1;

fig = figure('Position', [50, 20, 900, 500]);


hold_data = ...
    main_game(hObject, handles,gravity,ballSpeed);
ballSpeedHigh = hold_data(1,2);
ballDistanceHigh = hold_data(1,1);
swingForceHigh = hold_data(1,3);

close(fig);

range1 = sprintf('A%i', h);

sheet = 'highScoresSAC';

%xlswrite('highScoresSAC.xlsx',{userName, ballSpeed, ballDistance, swingForce}, sheet, range1);
xlswrite('highScoresSAC.xlsx',{userName, ballSpeedHigh, ballDistanceHigh...
    , swingForceHigh}, sheet, range1);

set(handles.ball_velocity, 'String', ballSpeedHigh);
set(handles.ball_distance, 'String', ballDistanceHigh);
set(handles.swing_force, 'String', swingForceHigh);


highSpeed = readHighScoreSpeed(num,txt);
highSwing = readHighScoreSwing(num,txt);
highDistance = readHighScoreDistance(num,txt);



set(handles.userNameHighSpeed, 'String',highSpeed(1,1));
set(handles.userNameHighDist, 'String',highDistance(1,1));
set(handles.userNameHighSwing, 'String',highSwing(1,1));
set(handles.ballSpeedHigh, 'String',highSpeed(1,2));
set(handles.ballDistanceHigh, 'String',highDistance(1,2));
set(handles.swingForceHigh, 'String',highSwing(1,2));

% Code to extract highscore values from highscore value


set(handles.play_ball, 'String', 'Play Ball!');

cla

clear all
