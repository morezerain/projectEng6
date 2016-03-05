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

% Last Modified by GUIDE v2.5 02-Mar-2016 10:46:22

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
function vidSlider_Callback(hObject, eventdata, handles)
% hObject    handle to vidSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function vidSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vidSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Rewind.
function Rewind_Callback(hObject, eventdata, handles)
% hObject    handle to Rewind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value'); 
if button_state == get(hObject,'Max')
      display('up')
 elseif button_state == get(hObject,'Min')
      display('down')
 end
vidStruct = handles.mov;
videoObject = handles.videoObject;
 currAxes = handles.axes2;
 Frames = vidStruct.cdata; %Extract Frames
   l=length(Frames);
   handles.l = l;
   playback =1;
         %Plays the video using for loop and image function
 if button_state == get(hObject,'Max')   
         for i=1:l
                image(vidStruct(i).cdata,'Parent', currAxes);
                currAxes.Visible = 'off';
                pause(1/videoObject.FrameRate);
                handles.i = i;
         end
 elseif button_state == get(hObject,'Min')
    return 
 end
       
   guidata(hObject,handles);
  
% --- Executes on button press in Pause.
function Pause_Callback(hObject, eventdata, handles)
% hObject    handle to Pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




 

% --- Executes on button press in Forward.
function Forward_Callback(hObject, eventdata, handles)
% hObject    handle to Forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
    
    handles.mov = mov;
    handles.videoObject = videoObject;
    guidata(hObject,handles)
   
   
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
    
    handles.mov = mov;
    handles.videoObject = videoObject;
    guidata(hObject,handles)
   
   
else 
    %Load video3
     videoObject = VideoReader('big_buck_bunny_720p_2mb.mp4');
     vidWidth = videoObject.Width;
    vidHeight = videoObject.Height;
    
    mov = struct('cdata', zeros(vidHeight,vidWidth,3,'uint8'),... %Creates empty mov structure
        'colormap',[]);
    k=1;
    while hasFrame(videoObject)
        mov(k).cdata = readFrame(videoObject);%Video frames are stored in structure pre buffering
       k = k+1;
    end
    
    handles.mov = mov;
    handles.videoObject = videoObject;
    guidata(hObject,handles)
   
end



% --- Executes on button press in Histogram.
function Histogram_Callback(hObject, eventdata, handles)
% hObject    handle to Histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Mute.
function Mute_Callback(hObject, eventdata, handles)
% hObject    handle to Mute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
