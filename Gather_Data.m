function varargout = Gather_Data(varargin)
% GATHER_DATA MATLAB code for Gather_Data.fig
%      GATHER_DATA, by itself, creates a new GATHER_DATA or raises the existing
%      singleton*.
%
%      H = GATHER_DATA returns the handle to a new GATHER_DATA or the handle to
%      the existing singleton*.
%
%      GATHER_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GATHER_DATA.M with the given input arguments.
%
%      GATHER_DATA('Property','Value',...) creates a new GATHER_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gather_Data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gather_Data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gather_Data

% Last Modified by GUIDE v2.5 31-Jan-2015 15:53:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gather_Data_OpeningFcn, ...
                   'gui_OutputFcn',  @Gather_Data_OutputFcn, ...
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


% --- Executes just before Gather_Data is made visible.
function Gather_Data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gather_Data (see VARARGIN)

% Choose default command line output for Gather_Data
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gather_Data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gather_Data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function numOfIterEdit_Callback(hObject, eventdata, handles)
% hObject    handle to numOfIterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numOfIterEdit as text
%        str2double(get(hObject,'String')) returns contents of numOfIterEdit as a double


% --- Executes during object creation, after setting all properties.
function numOfIterEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numOfIterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in acquireStepDataButton.
function acquireStepDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to acquireStepDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data;
global meanVal;
global modeVal;
global maxVal;
global minVal;

vid = videoinput('winvideo', 2,'YUY2_640x480');
set(vid, 'ReturnedColorSpace', 'YCbCr');

iter = str2double(get(handles.numOfIterEdit, 'String'));

data = zeros(iter);

set(handles.acquireStepDataButton,'enable','off');


for i = 1:iter
       
        
        ycbcr = getsnapshot(vid);
        rgb = ycbcr2rgb(ycbcr);
        
        % Remove the sky above the horizon

        sea_rgb = analysis.crop_sea(rgb);
        
        
        sea_gray = rgb2gray(sea_rgb);
        % Simplify image

        blockproc_img = analysis.blockproc_image(sea_gray);
        
        figure(1), imshow(blockproc_img, []);
        steps = analysis.count_steps(blockproc_img);
        
        data(i) = steps;
        % Save image
        pause(1);
    
end


meanArr = mean(data);
modeArr = mode(data);
minArr = min(data);
maxArr = max(data);

meanVal = meanArr(1);
modeVal = modeArr(1);
minVal = minArr(1);
maxVal = maxArr(1);

fileIDmean = fopen('D:\Matlab\Matlab 2012a\bin\Image Processing\Tidal State Recognition System\Step Data Acquisition\Mean.txt','w');
fileIDmode = fopen('D:\Matlab\Matlab 2012a\bin\Image Processing\Tidal State Recognition System\Step Data Acquisition\Mode.txt','w');
fileIDmax = fopen('D:\Matlab\Matlab 2012a\bin\Image Processing\Tidal State Recognition System\Step Data Acquisition\Max.txt','w');
fileIDmin = fopen('D:\Matlab\Matlab 2012a\bin\Image Processing\Tidal State Recognition System\Step Data Acquisition\Min.txt','w');

formatSpec = '%0.5f';

fprintf(fileIDmean, formatSpec, meanVal);
fprintf(fileIDmode, formatSpec, modeVal);
fprintf(fileIDmax, formatSpec, minVal);
fprintf(fileIDmin, formatSpec, maxVal);

fclose(fileIDmean);
fclose(fileIDmode);
fclose(fileIDmax);
fclose(fileIDmin);

set(handles.meanStepEdit, 'String', num2str(meanVal));
set(handles.modeStepEdit, 'String', num2str(modeVal));
set(handles.maxStepEdit, 'String', num2str(maxVal));
set(handles.minStepEdit, 'String', num2str(minVal));


close(figure(1));
set(handles.acquireStepDataButton, 'enable','on');



% --- Executes on button press in computeStepParametersButton.
function computeStepParametersButton_Callback(hObject, eventdata, handles)
% hObject    handle to computeStepParametersButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function meanStepEdit_Callback(hObject, eventdata, handles)
% hObject    handle to meanStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meanStepEdit as text
%        str2double(get(hObject,'String')) returns contents of meanStepEdit as a double


% --- Executes during object creation, after setting all properties.
function meanStepEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meanStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function modeStepEdit_Callback(hObject, eventdata, handles)
% hObject    handle to modeStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of modeStepEdit as text
%        str2double(get(hObject,'String')) returns contents of modeStepEdit as a double


% --- Executes during object creation, after setting all properties.
function modeStepEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modeStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minStepEdit_Callback(hObject, eventdata, handles)
% hObject    handle to minStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minStepEdit as text
%        str2double(get(hObject,'String')) returns contents of minStepEdit as a double


% --- Executes during object creation, after setting all properties.
function minStepEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxStepEdit_Callback(hObject, eventdata, handles)
% hObject    handle to maxStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxStepEdit as text
%        str2double(get(hObject,'String')) returns contents of maxStepEdit as a double


% --- Executes during object creation, after setting all properties.
function maxStepEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in returnMainMenuButton.
function returnMainMenuButton_Callback(hObject, eventdata, handles)
% hObject    handle to returnMainMenuButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openfig('Return_To_Main_Gather.fig');


% --- Executes on button press in exitSystemButton.
function exitSystemButton_Callback(hObject, eventdata, handles)
% hObject    handle to exitSystemButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openfig('Confirm_Exit_Menu.fig');
