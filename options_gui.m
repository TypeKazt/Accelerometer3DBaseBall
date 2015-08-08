function varargout = options_gui(varargin)
% OPTIONS_GUI MATLAB code for options_gui.fig
%      OPTIONS_GUI, by itself, creates a new OPTIONS_GUI or raises the existing
%      singleton*.
%
%      H = OPTIONS_GUI returns the handle to a new OPTIONS_GUI or the handle to
%      the existing singleton*.
%
%      OPTIONS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTIONS_GUI.M with the given input arguments.
%
%      OPTIONS_GUI('Property','Value',...) creates a new OPTIONS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before options_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to options_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help options_gui

% Last Modified by GUIDE v2.5 10-Mar-2015 13:26:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @options_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @options_gui_OutputFcn, ...
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


% --- Executes just before options_gui is made visible.
function options_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to options_gui (see VARARGIN)

% Choose default command line output for options_gui
handles.output = hObject;
set(handles.gravity, 'String', '9.81');
set(handles.userName, 'String', 'Anonymous');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes options_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = options_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in ball_speed.

% This function will take the input for the ball velocity allowing the user
% to change the intial velocity of the baseball. This menu will have
% discrete values to make the math less complicated and reduce the risk of
% errors.
function ball_speed_Callback(hObject, eventdata, handles)
% hObject    handle to ball_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ball_speed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ball_speed


% --- Executes during object creation, after setting all properties. 
function ball_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ball_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% This function will take the user input for gravity allowing the user to
% change the gravity in the game.
function gravity_Callback(hObject, eventdata, handles)
% hObject    handle to gravity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gravity as text
%        str2double(get(hObject,'String')) returns contents of gravity as a double


% --- Executes during object creation, after setting all properties.
function gravity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gravity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ball_size.

%This function takes the user input for ball size allowing them to change
%how big or small the ball is. This menu will have discrete values to make 
%the math less complicated and reduce the risk of errors.

function ball_size_Callback(hObject, eventdata, handles)
% hObject    handle to ball_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ball_size contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ball_size


% --- Executes during object creation, after setting all properties.
function ball_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ball_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%This function takes the user's input for wind speed as a constant
%velocity. Negative will blow the ball left and positive will blow the ball
%right.

function wind_speed_Callback(hObject, eventdata, handles)
% hObject    handle to wind_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wind_speed as text
%        str2double(get(hObject,'String')) returns contents of wind_speed as a double


% --- Executes during object creation, after setting all properties.
function wind_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wind_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in apply_options.

%This button will pass the values, set to the variables in the above
%functions, from this gui to the main program.

function apply_options_Callback(hObject, eventdata, handles)
% hObject    handle to apply_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

strSpeed = get(handles.ball_speed, 'String');

setappdata(0,'BallSpeed',str2double(strSpeed(get(handles.ball_speed, 'Value'))));
setappdata(0,'Gravity',str2double(get(handles.gravity, 'String')));
setappdata(0,'UserName', get(handles.userName, 'String'));

close options_gui




% --- Executes on selection change in resolution.
function resolution_Callback(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns resolution contents as cell array
%        contents{get(hObject,'Value')} returns selected item from resolution


% --- Executes during object creation, after setting all properties.
function resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function userName_Callback(hObject, eventdata, handles)
% hObject    handle to userName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userName as text
%        str2double(get(hObject,'String')) returns contents of userName as a double


% --- Executes during object creation, after setting all properties.
function userName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
