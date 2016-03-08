function varargout = gui113(varargin)
% GUI113 MATLAB code for gui113.fig
%      GUI113, by itself, creates a new GUI113 or raises the existing
%      singleton*.
%
%      H = GUI113 returns the handle to a new GUI113 or the handle to
%      the existing singleton*.
%
%      GUI113('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI113.M with the given input arguments.
%
%      GUI113('Property','Value',...) creates a new GUI113 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui113_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui113_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui113

% Last Modified by GUIDE v2.5 07-Mar-2016 21:52:50

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


% --- Executes just before gui113 is made visible.
function gui113_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui113 (see VARARGIN)

% Choose default command line output for gui113
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui113 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui113_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles =guidata(hObject);
v = VideoReader('nn.mp4');
height = v.Height;
width = v.Width;
framerate = v.FrameRate;
video_name = v.Name;
duration = sec2hms(v.Duration);
formatVideoData = ['Files:%s\n' ...
    'Resolustions:%d X %d \n'...
    'Framerate:%d\n'...
    'Total duration:%s\n'];
strinformation = sprintf(formatVideoData,video_name,width,height,framerate,duration);
set(handles.text2,'String',strinformation);
guidata(hObject,handles);
