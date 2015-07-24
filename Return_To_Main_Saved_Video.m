function varargout = Return_To_Main_Saved_Video(varargin)
% RETURN_TO_MAIN_SAVED_VIDEO MATLAB code for Return_To_Main_Saved_Video.fig
%      RETURN_TO_MAIN_SAVED_VIDEO, by itself, creates a new RETURN_TO_MAIN_SAVED_VIDEO or raises the existing
%      singleton*.
%
%      H = RETURN_TO_MAIN_SAVED_VIDEO returns the handle to a new RETURN_TO_MAIN_SAVED_VIDEO or the handle to
%      the existing singleton*.
%
%      RETURN_TO_MAIN_SAVED_VIDEO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RETURN_TO_MAIN_SAVED_VIDEO.M with the given input arguments.
%
%      RETURN_TO_MAIN_SAVED_VIDEO('Property','Value',...) creates a new RETURN_TO_MAIN_SAVED_VIDEO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Return_To_Main_Saved_Video_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Return_To_Main_Saved_Video_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Return_To_Main_Saved_Video

% Last Modified by GUIDE v2.5 30-Jan-2015 22:21:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Return_To_Main_Saved_Video_OpeningFcn, ...
                   'gui_OutputFcn',  @Return_To_Main_Saved_Video_OutputFcn, ...
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


% --- Executes just before Return_To_Main_Saved_Video is made visible.
function Return_To_Main_Saved_Video_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Return_To_Main_Saved_Video (see VARARGIN)

% Choose default command line output for Return_To_Main_Saved_Video
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Return_To_Main_Saved_Video wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Return_To_Main_Saved_Video_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in yesMenuButton.
function yesMenuButton_Callback(hObject, eventdata, handles)
% hObject    handle to yesMenuButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(instrfind('Type','serial'));

openfig('Main_Menu.fig');


close Saved_Video_Mode;

close Return_To_Main_Saved_Video;



% --- Executes on button press in noMenuButton.
function noMenuButton_Callback(hObject, eventdata, handles)
% hObject    handle to noMenuButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
