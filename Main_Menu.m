function varargout = Main_Menu(varargin)
% MAIN_MENU MATLAB code for Main_Menu.fig
%      MAIN_MENU, by itself, creates a new MAIN_MENU or raises the existing
%      singleton*.
%
%      H = MAIN_MENU returns the handle to a new MAIN_MENU or the handle to
%      the existing singleton*.
%
%      MAIN_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_MENU.M with the given input arguments.
%
%      MAIN_MENU('Property','Value',...) creates a new MAIN_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_Menu

% Last Modified by GUIDE v2.5 31-Jan-2015 15:31:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_Menu_OutputFcn, ...
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


% --- Executes just before Main_Menu is made visible.
function Main_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_Menu (see VARARGIN)

% Choose default command line output for Main_Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in realTimeButton.
function realTimeButton_Callback(hObject, eventdata, handles)
% hObject    handle to realTimeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA);

run Realtime_Monitor_System;
close Main_Menu;


% --- Executes on button press in savedVideoMenuButton.
function savedVideoMenuButton_Callback(hObject, eventdata, handles)
% hObject    handle to savedVideoMenuButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run Saved_Video_Mode;
close Main_Menu


% --- Executes on button press in exitSystemMenuButton.
function exitSystemMenuButton_Callback(hObject, eventdata, handles)
% hObject    handle to exitSystemMenuButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openfig('Confirm_Exit_Menu.fig','new');


% --- Executes on button press in generateSnapShot.
function generateSnapShot_Callback(hObject, eventdata, handles)
% hObject    handle to generateSnapShot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vid = videoinput('winvideo', 2,'YUY2_640x480');
set(vid, 'ReturnedColorSpace', 'YCbCr');


ycbcr = getsnapshot(vid);
rgb = ycbcr2rgb(ycbcr);
        

figure(1),imshow(rgb),title('\bfSnapshot Image');
        


% --- Executes on button press in gatherStepDataButton.
function gatherStepDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to gatherStepDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run Gather_Data;
close Main_Menu;