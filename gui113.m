function varargout = gui113(varargin)

% Last Modified by GUIDE v2.5 07-Mar-2016 22:37:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui113_OpeningFcn, ...
                   'gui_OutputFcn',  @gui113_OutputFcn, ...
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

function gui113_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

function varargout = gui113_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function load_Callback(hObject, eventdata, handles)
%-------------------browse and select video-------------------
[video_name, video_path] = uigetfile('*.mp4',...
    'select a video');
%if (video_name==0)&(video_path==0)
%expression what if the user didnt select any thing
%end
%--------------------For grabing video info----------------
handles =guidata(hObject);
videoObject = VideoReader(video_name);
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


%-----------------------For the video playing------------

function Play_Callback(hObject, eventdata, handles)
