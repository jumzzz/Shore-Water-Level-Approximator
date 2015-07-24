function varargout = Experimental_System(varargin)
% EXPERIMENTAL_SYSTEM MATLAB code for Experimental_System.fig
%      EXPERIMENTAL_SYSTEM, by itself, creates a new EXPERIMENTAL_SYSTEM or raises the existing
%      singleton*.
%
%      H = EXPERIMENTAL_SYSTEM returns the handle to a new EXPERIMENTAL_SYSTEM or the handle to
%      the existing singleton*.
%
%      EXPERIMENTAL_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENTAL_SYSTEM.M with the given input arguments.
%
%      EXPERIMENTAL_SYSTEM('Property','Value',...) creates a new EXPERIMENTAL_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experimental_System_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experimental_System_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experimental_System

% Last Modified by GUIDE v2.5 16-Jan-2015 21:17:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Experimental_System_OpeningFcn, ...
                   'gui_OutputFcn',  @Experimental_System_OutputFcn, ...
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


% --- Executes just before Experimental_System is made visible.
function Experimental_System_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Experimental_System (see VARARGIN)

% Choose default command line output for Experimental_System
handles.output = hObject;

set(handles.find_comport_button, 'enable','off');
set(handles.start_alarm_button, 'enable', 'off');
set(handles.stop_alarm_button, 'enable', 'off');

set(handles.tide_state_edit, 'String', ' ');
set(handles.danger_state_edit, 'String', ' ');

set(handles.connect_arduino_button, 'enable', 'off');
set(handles.disconnect_arduino_button, 'enable', 'off');

set(handles.arduino_comport_edit, 'String', ' ');
set(handles.arduino_connection_edit, 'String', 'Disconnected');

set(handles.generate_figure_orig_button, 'enable', 'off');
set(handles.generate_figure_processed_button, 'enable', 'off');
set(handles.generate_hierchy_button, 'enable', 'off');



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Experimental_System wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Experimental_System_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



set(handles.start_button, 'enable','off');
set(handles.find_comport_button, 'enable','on');

global rgb
global sea_rgb;
global sea_gray
global blockproc_img;

global steps;
global tide_level;
global danger_level;

global is_running;
global orig_counter;
global proc_counter;

is_running = 1;

orig_counter = 0;
proc_counter = 0;

set(handles.generate_figure_orig_button, 'enable', 'on');
set(handles.generate_figure_processed_button, 'enable', 'on');
set(handles.generate_hierchy_button, 'enable', 'on');

    while is_running

        orig_counter = orig_counter + 1;
        proc_counter = proc_counter + 1;
        
        orig_counter_str = sprintf('%d', orig_counter);
        proc_counter_str = sprintf('%d', proc_counter);
        
        rgb = imread('C:\Users\john\Desktop\image data\matlab image\realimage.jpg');

        % Remove the sky above the horizon
        sea_rgb = analysis.crop_sea(rgb);
        sea_gray = rgb2gray(sea_rgb);
        % Simplify image

        blockproc_img = analysis.blockproc_image(sea_gray);
        steps = analysis.count_steps(blockproc_img);

        [tide_level, danger_level] = analysis.tidal_status(steps);

        imshow(sea_rgb, 'Parent', handles.orig_img_axes);
        imshow(blockproc_img, [], 'Parent', handles.proc_img_axes);
        set(handles.tide_state_edit, 'String', tide_level);
        set(handles.danger_state_edit, 'String', danger_level);
        set(handles.orig_image_counter_edit, 'String', orig_counter_str);
        set(handles.proc_image_counter_edit, 'String', proc_counter_str);
        
        pause(30);

    end











% --- Executes on button press in find_comport_button.
function find_comport_button_Callback(hObject, eventdata, handles)
% hObject    handle to find_comport_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
comport_list = get_available_comport();

if ~isempty(comport_list)
   set(handles.find_comport_button, 'enable', 'off');
   set(handles.connect_arduino_button, 'enable', 'on');
   set(handles.arduino_comport_edit, 'String', comport_list{1});
   
end
fileID = fopen('D:\Matlab\Matlab 2012a\bin\Image Processing\Tidal State Recognition System\Port Connection\com_port.txt','w');

 for i = 1:length(comport_list)
    
     fprintf(fileID,'%s\n',comport_list{i});
     
 end
 

fclose(fileID);



function tide_state_edit_Callback(hObject, eventdata, handles)
% hObject    handle to tide_state_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tide_state_edit as text
%        str2double(get(hObject,'String')) returns contents of tide_state_edit as a double


% --- Executes during object creation, after setting all properties.
function tide_state_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tide_state_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function danger_state_edit_Callback(hObject, eventdata, handles)
% hObject    handle to danger_state_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of danger_state_edit as text
%        str2double(get(hObject,'String')) returns contents of danger_state_edit as a double


% --- Executes during object creation, after setting all properties.
function danger_state_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to danger_state_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function current_process_edit_Callback(~, eventdata, handles)
% hObject    handle to current_process_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of current_process_edit as text
%        str2double(get(hObject,'String')) returns contents of current_process_edit as a double


% --- Executes during object creation, after setting all properties.
function current_process_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to current_process_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arduino_edit_Callback(hObject, eventdata, handles)
% hObject    handle to arduino_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of arduino_edit as text
%        str2double(get(hObject,'String')) returns contents of arduino_edit as a double


% --- Executes during object creation, after setting all properties.
function arduino_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arduino_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start_alarm_button.
function start_alarm_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_alarm_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino_obj;
pinMode(arduino_obj, 10,'output');
digitalWrite(arduino_obj, 10, 1);
set(handles.start_alarm_button, 'enable', 'off');


% --- Executes on button press in stop_alarm_button.
function stop_alarm_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_alarm_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino_obj;
pinMode(arduino_obj, 10, 'output');
digitalWrite(arduino_obj, 10, 0);
set(handles.start_alarm_button, 'enable', 'on');


% --- Executes on button press in disconnect_arduino_button.
function disconnect_arduino_button_Callback(hObject, eventdata, handles)
% hObject    handle to disconnect_arduino_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

com_str = get(handles.arduino_comport_edit, 'String');
delete(instrfind({'Port'},{com_str}));
set(handles.arduino_connection_edit, 'String', 'Disconnected');
set(handles.connect_arduino_button, 'enable', 'on');
set(handles.disconnect_arduino_button, 'disconnect', 'off');


% --- Executes on button press in connect_arduino_button.
function connect_arduino_button_Callback(hObject, eventdata, handles)
% hObject    handle to connect_arduino_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino_obj;

com_str = get(handles.arduino_comport_edit,'String');
arduino_obj = arduino(com_str);
pinMode(arduino_obj, 10, 'output');

set(handles.disconnect_arduino_button,'enable', 'on');
set(handles.connect_arduino_button,'enable','off');
set(handles.start_alarm_button, 'enable', 'on');
set(handles.stop_alarm_button, 'enable', 'on');
set(handles.arduino_connection_edit, 'String', 'Connected');
digitalWrite(arduino_obj, 10, 0);




% --- Executes on button press in return_button.
function return_button_Callback(hObject, eventdata, handles)
% hObject    handle to return_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exit_button.
function exit_button_Callback(hObject, eventdata, handles)
% hObject    handle to exit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global is_running;
is_running = 0;
delete(instrfind('Type','serial'));
clear all;
close all;
clc;



function arduino_connection_edit_Callback(hObject, eventdata, handles)
% hObject    handle to arduino_connection_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of arduino_connection_edit as text
%        str2double(get(hObject,'String')) returns contents of arduino_connection_edit as a double


% --- Executes during object creation, after setting all properties.
function arduino_connection_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arduino_connection_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arduino_comport_edit_Callback(hObject, eventdata, handles)
% hObject    handle to arduino_comport_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of arduino_comport_edit as text
%        str2double(get(hObject,'String')) returns contents of arduino_comport_edit as a double


% --- Executes during object creation, after setting all properties.
function arduino_comport_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arduino_comport_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generate_figure_orig_button.
function generate_figure_orig_button_Callback(hObject, eventdata, handles)
% hObject    handle to generate_figure_orig_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sea_rgb;
figure(1), imshow(sea_rgb),title('\bfCropped Image of Original Input ');


% --- Executes on button press in generate_figure_processed_button.
function generate_figure_processed_button_Callback(hObject, eventdata, handles)
% hObject    handle to generate_figure_processed_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blockproc_img;
figure(2), imshow(blockproc_img, []), title('\bfSimplified Image of Cropped Image');


% --- Executes on button press in generate_hierchy_button.
function generate_hierchy_button_Callback(hObject, eventdata, handles)
% hObject    handle to generate_hierchy_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rgb
global sea_rgb;
global sea_gray
global blockproc_img;

figure(3);
subplot(2,2,1), imshow(rgb), title('\bf1. Acquire Input Image');
subplot(2,2,2), imshow(sea_rgb), title('\bf2. Eliminate the Sky by cropping');
subplot(2,2,3), imshow(sea_gray), title('\bf3. Turn rgb image to binary');
subplot(2,2,4), imshow(blockproc_img, []), title('\bf4. Apply Simplification Algorithm');



function orig_image_counter_edit_Callback(hObject, eventdata, handles)
% hObject    handle to orig_image_counter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orig_image_counter_edit as text
%        str2double(get(hObject,'String')) returns contents of orig_image_counter_edit as a double


% --- Executes during object creation, after setting all properties.
function orig_image_counter_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orig_image_counter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function proc_image_counter_edit_Callback(hObject, eventdata, handles)
% hObject    handle to proc_image_counter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of proc_image_counter_edit as text
%        str2double(get(hObject,'String')) returns contents of proc_image_counter_edit as a double


% --- Executes during object creation, after setting all properties.
function proc_image_counter_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to proc_image_counter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
