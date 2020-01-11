function varargout = Main(varargin)

% khoi tao
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Thuc thi khi Main duoc chay
function Main_OpeningFcn(hObject, eventdata, handles, varargin)

set(hObject,'Name','Nhan dien ky tu quang hoc');
movegui(hObject,'center');
% chon dau ra mac dinh cho Main
handles.output = hObject;

% Cap nhat cau truc xu ly
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dau ra tra ve lenh
function varargout = Main_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% thuc hien tren nut an train
function pushbutton1_Callback(hObject, eventdata, handles)
    train_nn;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% thuc hien tren nut an orc window.
function pushbutton2_Callback(hObject, eventdata, handles)
if exist('DataBase.mat','file') == 2%2
    OCR_Window;
else
    error_no_nn_exist;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pushbutton3_Callback(hObject, eventdata, handles)
if exist('DataBase.mat','file') == 2%2
    delete('DataBase.mat');
end
