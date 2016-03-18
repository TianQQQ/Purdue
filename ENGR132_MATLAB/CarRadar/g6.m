function varargout = g6(varargin)
% g6 MATLAB code for g6.fig
%      g6, by itself, creates a new g6 or raises the existing
%      singleton*.
%
%      H = g6 returns the handle to a new g6 or the handle to
%      the existing singleton*.
%
%      g6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in g6.M with the given input arguments.
%
%      g6('Property','Value',...) creates a new g6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before g6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to g6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help g6

% Last Modified by GUIDE v2.5 04-Aug-2014 13:04:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @g6_OpeningFcn, ...
                   'gui_OutputFcn',  @g6_OutputFcn, ...
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


% --- Executes just before g6 is made visible.
function g6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to g6 (see VARARGIN)

% Choose default command line output for g6
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes g6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = g6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,path] = uigetfile('*');
data_radar0 = load([path, filename]);
handles.data_radar0 = data_radar0;
set(handles.edit1,'String',filename);
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,path] = uigetfile('*');
data_detection0 = load([path, filename]);
handles.data_detection0 = data_detection0;
set(handles.edit4,'String',filename);
guidata(hObject, handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,path] = uigetfile('*');
data_tracks = load([path, filename]);
handles.data_tracks = data_tracks;
set(handles.edit3,'String',filename);
guidata(hObject, handles);



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
[filename,path] = uigetfile('*');
data_vehicles = load([path, filename]);
handles.data_vehicles = data_vehicles;
set(handles.edit2,'String',filename);
guidata(hObject, handles);

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 index=1;
 index1=1;
 index2=1;
 index3=1;
 index4=1;
 index5=1;
 index9=1;
 index10=1;
 index12=1;

 
 tv_max=floor((max(handles.data_vehicles(:,1)))*1000)/1000;
 tv_min=floor((min(handles.data_vehicles(:,1)))*1000)/1000;
 
 tt_max=floor((max(handles.data_tracks(:,1)))*1000)/1000;
 tt_min=floor((min(handles.data_tracks(:,1)))*1000)/1000;
 
 dd0 = handles.data_detection0(:,3);
 dd1 = handles.data_detection1(:,3);
 
 ad0 = handles.data_detection0(:,5);
 ad1 = handles.data_detection1(:,5);
 
  td0_max=floor((max(handles.data_detection0(:,1)))*1000)/1000;
  td0_min=floor((min(handles.data_detection0(:,1)))*1000)/1000;

  td1_max=floor((max(handles.data_detection1(:,1)))*1000)/1000;
  td1_min=floor((min(handles.data_detection1(:,1)))*1000)/1000;
  
   IDt = handles.data_tracks(:,2);
   ID0 = handles.data_detection0(:,2);
   ID1 = handles.data_detection1(:,2);
   
 n = 0 ; 
 ylim([-40 10]);
 xlim([-100 20]);
 
for t = tv_min:0.025:tv_max

      n = n +1
      set(handles.text26,'String',num2str(t));
      if mod(n,2) == 1 
        set(handles.text13,'String',handles.data_vehicles(index1,2));
        set(handles.text14,'String',handles.data_vehicles(index1,3));
        index1=index1 + 1;
        rectangle('Position', [-14 1.5 14 3.75],'Curvature',[0 0], 'FaceColor','y');
        rectangle('Position', [-14 -5.25 14 3.75],'Curvature',[0 0], 'FaceColor','y');
        rectangle('Position', [-70 1.5 56 3.75],'Curvature',[0 0], 'FaceColor','c');
        rectangle('Position', [-70 -5.25 56 3.75],'Curvature',[0 0], 'FaceColor','c');
        rectangle('Position', [-5 -1 5 2], 'Curvature', [0.5 0.5], 'FaceColor','k'); 


        if  ( t >= tt_min ) & ( t <= tt_max) 
        warning_index = 0;
        zone_index = 0;
        for index11 = 1:max(IDt)

            if (IDt(index12,1) == index11) & (index12 < length(IDt))
            x_pos=handles.data_tracks(index12,4);
            y_pos=handles.data_tracks(index12,7);
            l=handles.data_tracks(index12,11);
            w=handles.data_tracks(index12,10);
            vx = handles.data_tracks(index12,5)/10;
            vy = handles.data_tracks(index12,8)/10;
            rectangle('Position',[x_pos,y_pos,w,l],'Curvature',[0.5,0.5],'FaceColor','r');
            hold on
            quiver((x_pos+w),(y_pos+0.5*l),vx,vy);
            if abs(handles.data_tracks(index12,5)) > 25
                warning_index = warning_index + 1;
            end

            if (((x_pos+w) < (-14) ) & ( (x_pos+w) > (-70) )) & ( ((y_pos+0.5*l) < (-1.5) & (y_pos+0.5*l) > (-5.25)) | ( (y_pos+0.5*l) > 1.5 & (y_pos+0.5*l) < 5.25 ) )
                zone_index = zone_index + 1;
            elseif (((x_pos+w) < 0) & ( (x_pos+w) > (-14) )) & ( ((y_pos+0.5*l) < (-1.5) & (y_pos+0.5*l) > (-5.25)) | ( (y_pos+0.5*l) > 1.5 & (y_pos+0.5*l) < 5.25 ) )
                zone_index = zone_index + 5;
            end

            pause(0.025);
            index12=index12+1;
            end 
        end   
        if warning_index > 0
            set (handles.text24, 'String', 'Warning! Vehicles approaching in high speed','ForegroundColor','r');
        else
            set (handles.text24, 'String', 'No vehicles approaching in high speed','ForegroundColor','g');
        end
        if zone_index == 0
            set(handles.text18, 'String', 'No Vehicles inside Closing Vehicle Zone','ForegroundColor','g');
        elseif zone_index == 1 || zone_index == 2 || zone_index == 3
            set(handles.text18, 'String', 'Attention! Vehicles inside Closing Vehicle Zone', 'ForegroundColor','m');
        else
            set(handles.text18, 'String', 'Warning! Vehicles inside Blind Spot Zone','ForegroundColor','r');
        end
                            
      if  ( t >= td0_min) & ( t <= td0_max) & (index9 < length(ID0) )
                for index7 = 1:max(ID0)
                    if ID0(index9,1) == index7
                        y = -5 - cos((-120) + ad0(index9,1) + 90 ) * dd0(index9,1);
                        x = 1 - sin((-120) + ad0(index9,1) + 90 ) * dd0(index9,1);
                        rectangle('Position', [x y 0.1 0.1],'Curvature',[0.5,0.5],'FaceColor','b');

                        index9=index9+1;
                    end                   
                end
       pause(0.025);
      end 
    
      else
         if  ( t >= td1_min) & ( t <= td1_max)
                for index8 = 1:max(ID1)
                    if (ID1(index10,1) == index8) & (index10 < length(ID1))
                        y = 1 - sin((-120) + ad1(index10,1) + 90 ) * dd1(index10,1);
                        x = -5 - cos((-120) + ad1(index10,1) + 90 ) * dd1(index10,1);
                        rectangle('Position', [x y 0.1 0.1],'Curvature',[0.5,0.5],'FaceColor','b');

                        index10=index10+1;
                    end 
                end 
         end 
       pause(0.025);
        end
     cla;
      end

end
        set(handles.text13,'String',0);
        set(handles.text14,'String',0);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
open('g1.fig');


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
[filename,path] = uigetfile('*');
data_detection1 = load([path, filename]);
handles.data_detection1 = data_detection1;
set(handles.edit5,'String',filename)
guidata(hObject, handles);
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
[filename,path] = uigetfile('*');
data_radar1 = load([path, filename]);
handles.data_radar1 = data_radar1;
set(handles.edit6,'String',filename);
guidata(hObject, handles);
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if get(handles.pushbutton17,'Value') == 1
%     pause;
%     set(handles.pushbutton17,'Value',0)
% elseif get(handles.pushbutton17,'Value') == 0
%     unpause;
%     set(handles.pushbuttion17,'Value',1)
% end 


% --- Executes on slider movement.



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double
x_min = str2num(get(handles.edit11,'String'));
handles.x_min = x_min;
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double
y_max = str2num(get(handles.edit12,'String'));
handles.y_max = y_max;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double
y_min = str2num(get(handles.edit13,'String'));
handles.y_min = y_min;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x_max = str2num(get(handles.edit7,'String'));
handles.x_max = x_max;
guidata(hObject, handles);

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x_min = str2num(get(handles.edit11,'String'));
handles.x_min = x_min;
guidata(hObject, handles);

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y_max = str2num(get(handles.edit12,'String'));
handles.y_max = y_max;
guidata(hObject, handles);

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y_min = str2num(get(handles.edit13,'String'));
handles.y_min = y_min;
guidata(hObject, handles);


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiwait;


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume
