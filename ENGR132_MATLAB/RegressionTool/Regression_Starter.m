function varargout = Regression_Starter(varargin)
% REGRESSION_STARTER MATLAB code for Regression_Starter.fig
%      REGRESSION_STARTER, by itself, creates a new REGRESSION_STARTER or raises the existing
%      singleton*.
%
%      H = REGRESSION_STARTER returns the handle to a new REGRESSION_STARTER or the handle to
%      the existing singleton*.
%
%      REGRESSION_STARTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGRESSION_STARTER.M with the given input arguments.
%
%      REGRESSION_STARTER('Property','Value',...) creates a new REGRESSION_STARTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Regression_Starter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Regression_Starter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Regression_Starter

% Last Modified by GUIDE v2.5 22-Jul-2014 23:17:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Regression_Starter_OpeningFcn, ...
    'gui_OutputFcn',  @Regression_Starter_OutputFcn, ...
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

% --- Executes just before Regression_Starter is made visible.
function Regression_Starter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Regression_Starter (see VARARGIN)

% Choose default command line output for Regression_Starter
handles.output = hObject;

% Hide manual data entry when Gui first opens
set(handles.panel_Manual, 'Visible', 'off');

%set default line color to black
handles.colors = 'Black';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Regression_Starter wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Regression_Starter_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in push_PlotFile.
function push_PlotFile_Callback(hObject, eventdata, handles)
% hObject    handle to push_PlotFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in check_MajorX.
function check_MajorX_Callback(hObject, eventdata, handles)
% hObject    handle to check_MajorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_MajorX

gridon = get(hObject, 'Value');

if gridon == 1
    set(handles.axes1, 'XGrid', 'On');
else
    set(handles.axes1, 'XGrid', 'Off');
end


% --- Executes on button press in check_MinorX.
function check_MinorX_Callback(hObject, eventdata, handles)
% hObject    handle to check_MinorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_MinorX
gridon = get(hObject, 'Value');

if gridon == 1
    set(handles.axes1, 'XMinorGrid', 'On');
else
    set(handles.axes1, 'XMinorGrid', 'Off');
end

% --- Executes on button press in check_MajorY.
function check_MajorY_Callback(hObject, eventdata, handles)
% hObject    handle to check_MajorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_MajorY
gridon = get(hObject, 'Value');

if gridon == 1
    set(handles.axes1, 'YGrid', 'On');
else
    set(handles.axes1, 'YGrid', 'Off');
end

% --- Executes on button press in check_MinorY.
function check_MinorY_Callback(hObject, eventdata, handles)
% hObject    handle to check_MinorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_MinorY
gridon = get(hObject, 'Value');

if gridon == 1
    set(handles.axes1, 'YMinorGrid', 'On');
else
    set(handles.axes1, 'YMinorGrid', 'Off');
end

function edit_XData_Callback(hObject, eventdata, handles)
% hObject    handle to edit_XData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_XData as text
%        str2double(get(hObject,'String')) returns contents of edit_XData as a double


% --- Executes during object creation, after setting all properties.
function edit_XData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_XData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_YData_Callback(hObject, eventdata, handles)
% hObject    handle to edit_YData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_YData as text
%        str2double(get(hObject,'String')) returns contents of edit_YData as a double


% --- Executes during object creation, after setting all properties.
function edit_YData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_YData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_PlotManual.
function push_PlotManual_Callback(hObject, eventdata, handles)
% hObject    handle to push_PlotManual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_FitLine.
function push_FitLine_Callback(hObject, eventdata, handles)
% hObject    handle to push_FitLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Determine least squares coefficients and the y values of the best fit line
coeffs = polyfit(handles.x, handles.y, 1);
y_fit = polyval(coeffs, handles.x);

% Plot the best fit line
plot(handles.x, y_fit, handles.color, 'LineWidth', 2)

% Save the coefficients to the handles vector
handles.coeffs = coeffs;

% Enable push button to display best fit equation
set(handles.push_ShowBestFit, 'Enable', 'on');

% Update handles structure
guidata(hObject,handles);

% --- Executes on button press in push_PlaceOutlier.
function push_PlaceOutlier_Callback(hObject, eventdata, handles)
% hObject    handle to push_PlaceOutlier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_ShowBestFit.
function push_ShowBestFit_Callback(hObject, eventdata, handles)
% hObject    handle to push_ShowBestFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Sent coefficients best fit equation GUI
ShowBestFit(handles.coeffs);


% --- Executes on slider movement.
function slider_Y_Callback(hObject, eventdata, handles)
% hObject    handle to slider_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_X_Callback(hObject, eventdata, handles)
% hObject    handle to slider_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popup_Line.
function popup_Line_Callback(hObject, eventdata, handles)
% hObject    handle to popup_Line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_Line contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_Line
contents = cellstr(get(hObject, 'string'));
handles.color = contents{get(hObject, 'Value'));

%unpdate handles structure
guidata(hObject, handles)



% --- Executes during object creation, after setting all properties.
function popup_Line_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_Line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_Marker.
function popup_Marker_Callback(hObject, eventdata, handles)
% hObject    handle to popup_Marker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_Marker contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_Marker



% --- Executes during object creation, after setting all properties.
function popup_Marker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_Marker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_ClearOutliers.
function push_ClearOutliers_Callback(hObject, eventdata, handles)
% hObject    handle to push_ClearOutliers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_ClearData.
function push_ClearData_Callback(hObject, eventdata, handles)
% hObject    handle to push_ClearData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in group_DataInput.
function group_DataInput_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in group_DataInput
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%Get tag of selected radio button
dataMode = get(eventdata.NewValue, 'tag');

%use switch to make proper method visible and the other invisble 
switch dataMode
    case 'radio_InputFile'
        set(handles.push_PlotFile, 'Visible', 'On');
        set(handles.panel_Manual, 'Visible', 'off');
    case 'radio_InputManual'
        set(handles.push_PlotFile, 'Visible', 'off');
        set(handles.panel_Manual, 'Visible', 'on');
end
