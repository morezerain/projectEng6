function varargout = Video_GUI(varargin)
% VIDEO_GUI MATLAB code for Video_GUI.fig
%      VIDEO_GUI, by itself, creates a new VIDEO_GUI or raises the existing
%      singleton*.
%
%      H = VIDEO_GUI returns the handle to a new VIDEO_GUI or the handle to
%      the existing singleton*.
%
%      VIDEO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIDEO_GUI.M with the given input arguments.
%
%      VIDEO_GUI('Property','Value',...) creates a new VIDEO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Video_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Video_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Video_GUI

% Last Modified by GUIDE v2.5 12-Mar-2016 17:47:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Video_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Video_GUI_OutputFcn, ...
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


% --- Executes just before Video_GUI is made visible.
function Video_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Video_GUI (see VARARGIN)
% Choose default command line output for Video_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Video_GUI wait for user response (see UIRESUME)
% uiwait(handles.Slider);


% --- Outputs from this function are returned to the command line.
function varargout = Video_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider, 'max', handles.l);

value = get(handles.slider, 'Value');
handles.i = round(value);
guidata(hObject,handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(handles.slider, 'min', 1);
set(handles.slider, 'max', 337);
set(handles.slider, 'Value', 1);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Rewind.
function Rewind_Callback(hObject, eventdata, handles)
% hObject    handle to Rewind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('A')
vidStruct = handles.mov;
PlayButton = handles.Play;
PlayButton.Value = 0;
CurrAxes = handles.axes2;
i = handles.i;
i = i-10
if i > 0
image(vidStruct(i).cdata,'Parent',handles.axes2)
CurrAxes.Visible = 'off';
handles.i = i;
end





guidata(hObject,handles);

 




% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.button_state = get(hObject,'Value');
if handles.button_state == get(hObject,'Max')
      display('up')
 elseif handles.button_state == get(hObject,'Min')
      display('down')
 end
vidStruct = handles.mov;
[m,n]=size(vidStruct);
videoObject = handles.videoObject;
 currAxes = handles.axes2;
 Frames = vidStruct.cdata;%Extract Frames
 handles.Frames = Frames;
   handles.l = n;
   handles.state =1;
         %Plays the video using for loop and image function
 if handles.button_state == get(hObject,'Max')   
     for i=handles.i:handles.l
             if handles.button_state == 1  
                image(vidStruct(i).cdata,'Parent', currAxes);
                currAxes.Visible = 'off';
                pause(1/videoObject.FrameRate);
                handles.button_state = get(hObject,'Value');
                handles.i =i;
              
             else
                 handles.i = i;
                 break
             end
         end
 end

     
 
       
   guidata(hObject,handles);
 

% --- Executes on button press in Forward.
function Forward_Callback(hObject, eventdata, handles)
% hObject    handle to Forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('A')
vidStruct = handles.mov;
PlayButton = handles.Play;
PlayButton.Value = 0;
CurrAxes = handles.axes2;
i = handles.i;
i = i+10
if i > 0
image(vidStruct(i).cdata,'Parent',handles.axes2)
CurrAxes.Visible = 'off';
handles.i = i;
end





guidata(hObject,handles);

% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Message = {'Please select a video:'};
mchoices = {'Video1' 'Video2' 'Video3' };
selection = menu(Message, mchoices);%Opens up Menu that allows user to select Video

%If statement that determines what video to load
if selection == 1
    %Load Video 1
    videoObject = VideoReader('big_buck_bunny_480p_1mb.mp4');
   
    vidWidth = videoObject.Width;
    vidHeight = videoObject.Height;
    
    mov = struct('cdata', zeros(vidHeight,vidWidth,3,'uint8'),... %Creates empty mov structure
        'colormap',[]);
    k=1;
    while hasFrame(videoObject)
        mov(k).cdata = readFrame(videoObject);%Video frames are stored in structure pre buffering
       k = k+1;
    end

%load Video 2   
elseif selection ==2;
    
    videoObject = VideoReader('big_buck_bunny_720p_1mb.mp4'); 
    
    vidWidth = videoObject.Width;
    vidHeight = videoObject.Height;
    
    mov = struct('cdata', zeros(vidHeight,vidWidth,3,'uint8'),... %Creates empty mov structure
        'colormap',[]);
    k=1;
    while hasFrame(videoObject)
        mov(k).cdata = readFrame(videoObject);%Video frames are stored in structure pre buffering
       k = k+1;
    end
    
 
   
else 
    %Load video3
     videoObject = VideoReader('big_buck_bunny_720p_2mb.mp4')
     vidWidth = videoObject.Width;
    vidHeight = videoObject.Height;
    
    mov = struct('cdata', zeros(vidHeight,vidWidth,3,'uint8'),... %Creates empty mov structure
        'colormap',[]);
    k=1;
    while hasFrame(videoObject)
        mov(k).cdata = readFrame(videoObject);%Video frames are stored in structure pre buffering
       k = k+1;
    end
    
    
    
   
   
end






%-------Load the RGB Values------------%
handles.mov = mov;
vidStruct = handles.mov;
[m,n]=size(vidStruct);
handles.l = n
handles.i= 1;
Frames = handles.mov;
handles.len = length(Frames);
handles.cond = 1;

RGB = uint8(zeros(size(Frames(handles.i).cdata)));
R = uint8(zeros(size(Frames(handles.i).cdata)));
G = uint8(zeros(size(Frames(handles.i).cdata)));
B = uint8(zeros(size(Frames(handles.i).cdata)));
for j= 1:handles.l
RGB = Frames(j).cdata;
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

[yR, x] = imhist(R);
[yG, x] = imhist(G);
[yB, x] = imhist(B);
yRed(:,j) = [yR];
yGreen(:,j) = [yG];
yBlue(:,j) = [yB];
end



%------Load The music player--------%
[y, fs] = audioread('Song.wav');
p = audioplayer(y, fs);

%------Load Music 2----------%
[y2, fs] = audioread('Song.wav');
y2 = flipud(y2);
player = audioplayer(y2, fs);
%------Load The music player--------%
[y, fs] = audioread('Song.wav');
player3 = audioplayer(y, fs*3);


%-------Handle Variables-------%
handles.player = p;
handles.player2 = player;
handles.player3 = player3;
handles.yRed = yRed;
handles.yGreen = yGreen;
handles.yBlue = yBlue;
handles.x = x;
handles.i= 1;
handles.mov = mov;
handles.videoObject = videoObject;

     guidata(hObject,handles)



% --- Executes on button press in Histogram.
function Histogram_Callback(hObject, eventdata, handles)
% hObject    handle to Histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yRed = handles.yRed;
yGreen = handles.yGreen;
yBlue = handles.yBlue;
x = handles.x;
Axes = handles.axes3;
videoObject = handles.videoObject;
for w = handles.i:handles.len
 plot(x,yRed(:,w),'r','Parent', Axes)
 hold on
 plot(x,yGreen(:,w),'g','Parent', Axes)
 plot(x,yBlue(:,w),'b','Parent', Axes)
 pause(.005)
 cla(Axes)
end

guidata(hObject,handles)




    



% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Play = handles.Play;
vidStruct = handles.mov;
Play.Value = 0;

handles.i = 1;
Axes = handles.axes2;
image(vidStruct(1).cdata,'Parent',handles.axes2)
Axes.Visible = 'off';
handles.i = 1;

guidata(hObject,handles);


% --- Executes on button press in Music.
function Music_Callback(hObject, eventdata, handles)
% hObject    handle to Music (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_sound = get(hObject,'Value');
p = handles.player;
if button_sound == get(hObject,'Max')
      display('up')
 elseif button_sound == get(hObject,'Min')
      display('down')
end
if button_sound == 1;
    play(p)
else
    pause(p)


end


guidata(hObject,handles);


% --- Executes on button press in music_2.
function music_2_Callback(hObject, eventdata, handles)
% hObject    handle to music_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_sound = get(hObject,'Value');
p = handles.player2;
if button_sound == get(hObject,'Max')
      display('up')
 elseif button_sound == get(hObject,'Min')
      display('down')
end
if button_sound == 1;
    play(p)
else
    pause(p)


end
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of music_2


% --- Executes on button press in Music_3.
function Music_3_Callback(hObject, eventdata, handles)
% hObject    handle to Music_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_sound = get(hObject,'Value');
p = handles.player3;
if button_sound == get(hObject,'Max')
      display('up')
 elseif button_sound == get(hObject,'Min')
      display('down')
end
if button_sound == 1;
    play(p)
else
    pause(p)


end
guidata(hObject,handles)
% Hint: get(hObject,'Value') returns toggle state of Music_3
