function varargout = Video_GUI(varargin)


% Last Modified by GUIDE v2.5 08-Mar-2016 20:29:53

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




function varargout = Video_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


function vidSlider_Callback(hObject, eventdata, handles)

function vidSlider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Rewind.
function Rewind_Callback(hObject, eventdata, handles)

i = handles.i
rewind = i - 10;
handles.i = rewind;
guidata(hObject,handles);
 




% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
button_state = get(hObject,'Value'); 
if button_state == get(hObject,'Max')
      display('up')
 elseif button_state == get(hObject,'Min')
      display('down')
 end
vidStruct = handles.mov;
videoObject = handles.videoObject;
 currAxes = handles.axes2;
 Frames = vidStruct.cdata;%Extract Frames
 handles.Frames = Frames;
   l=length(Frames);
   handles.l = l;
         %Plays the video using for loop and image function
 if button_state == get(hObject,'Max')   
         for i=handles.i:handles.l
             if button_state == 1 
                image(vidStruct(i).cdata,'Parent', currAxes);
                currAxes.Visible = 'off';
                pause(1/videoObject.FrameRate);
                handles.i = i;
                button_state = get(hObject,'Value');
             else
                 handles.i = i;
                 break
             end
         end
 end
 
 
     
 
       
   guidata(hObject,handles);
 

% --- Executes on button press in Forward.
function Forward_Callback(hObject, eventdata, handles)


% --- Executes on button press in load.

%If statement that determines what video to load
function load_Callback(hObject, eventdata, handles)
%-------------------browse and select video-------------------
[video_name, video_path] = uigetfile('*.mp4',...
    'select a video');
%fopen(fullfile(video_path,video_name) )
%if (video_name==0)&(video_path==0)
%expression what if the user didnt select any thing
%end
%--------------------For grabing video info----------------
handles =guidata(hObject);
videoObject = VideoReader(strcat(video_path,video_name));
global vidHeight vidWidth framerate
vidHeight = videoObject.Height;
vidWidth = videoObject.Width;
framerate = videoObject.FrameRate;
duration = sec2hms(videoObject.Duration);
formatVideoData = ['Files:%s\n' ...
    'Resolustions:%d X %d \n'...
    'Framerate:%d\n'...
    'Total duration:%s\n'];
strinformation = sprintf(formatVideoData,video_name,vidWidth,vidHeight,framerate,duration);
set(handles.text2,'String',strinformation);
    
mov = struct('cdata', zeros(vidHeight,vidWidth,3,'uint8'),... %Creates empty mov structure
    'colormap',[]);
k=1;
while hasFrame(videoObject)
    mov(k).cdata = readFrame(videoObject);%Video frames are stored in structure pre buffering
    k = k+1;
end
    handles.mov = mov;
    handles.videoObject = videoObject;
    handles.i= 1;
    guidata(hObject,handles)
   
  

% --- Executes on button press in Histogram.
function Histogram_Callback(hObject, eventdata, handles)
% hObject    handle to Histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state2 = get(hObject,'Value'); 

if button_state2 == get(hObject,'Max') %Heps me know if "switch" is on or off
      display('up')
 elseif button_state2 == get(hObject,'Min')
      display('down')
end
Axes3 = handles.axes3;
vidStruct = handles.mov;


if button_state2 == 1
images = vidStruct(handles.i).cdata; % Extract the frame(2 in this case)

Red = uint8(zeros(size(images)));
Green = uint8(zeros(size(images)));%Empty 3D Arrays
Blue = uint8(zeros(size(images)));

Red(:,:,1) = images(:,:,1);%Red Green and Blue Layers
[m n z ] = size(Red);
for i = 1:m
    for j = 1:n
        y(i,j) = Red(i,j,1);
    end
end
 [yRed, x] = imhist(y);
 plot(x,yRed,'r','Parent',Axes3);

 Green(:,:,2) = images(:,:,2);
 [m n z ] = size(Green);
for i = 1:m
    for j = 1:n
        y(i,j) = Green(i,j,2);
    end
end
  [yGreen, x] = imhist(y);
  hold on
  plot(x,yGreen,'g','Parent',Axes3);
 
 Blue(:,:,3) = images(:,:,3);
 [m n z ] = size(Blue);
for i = 1:m
    for j = 1:n
        y(i,j) = Blue(i,j,3);
    end
end
  [yBlue, x] = imhist(y);
  plot(x,yBlue,'b','Parent',Axes3);
  hold off
  
else 
    cla(Axes3)
end


guidata(hObject,handles)



% --- Executes on button press in Mute.
function Mute_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
