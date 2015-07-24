function varargout = Confirm_Exit_Menu(varargin)
% CONFIRM_EXIT_MENU MATLAB code for Confirm_Exit_Menu.fig
%      CONFIRM_EXIT_MENU, by itself, creates a new CONFIRM_EXIT_MENU or raises the existing
%      singleton*.
%
%      H = CONFIRM_EXIT_MENU returns the handle to a new CONFIRM_EXIT_MENU or the handle to
%      the existing singleton*.
%
%      CONFIRM_EXIT_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIRM_EXIT_MENU.M with the given input arguments.
%
%      CONFIRM_EXIT_MENU('Property','Value',...) creates a new CONFIRM_EXIT_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Confirm_Exit_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Confirm_Exit_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Confirm_Exit_Menu

% Last Modified by GUIDE v2.5 30-Jan-2015 21:25:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Confirm_Exit_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Confirm_Exit_Menu_OutputFcn, ...
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


% --- Executes just before Confirm_Exit_Menu is made visible.
function Confirm_Exit_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Confirm_Exit_Menu (see VARARGIN)

% Choose default command line output for Confirm_Exit_Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Confirm_Exit_Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Confirm_Exit_Menu_OutputFcn(hObject, eventdata, handles) 
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
clear all;
close all;
clc;


% --- Executes on button press in noMenuButton.
function noMenuButton_Callback(hObject, eventdata, handles)
% hObject    handle to noMenuButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
