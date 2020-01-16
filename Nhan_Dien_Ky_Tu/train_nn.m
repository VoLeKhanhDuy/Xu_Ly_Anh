function varargout = train_nn(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @train_nn_OpeningFcn, ...
                   'gui_OutputFcn',  @train_nn_OutputFcn, ...
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

% thuc thi train.
function train_nn_OpeningFcn(hObject, eventdata, handles, varargin)

% chon dau ra cho train_nn
handles.output = hObject;

% cap nhat cau truc xu ly
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% dau ra cua cac chuc nang duoc tra ve dong lenh
function varargout = train_nn_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function edit1_Callback(hObject, eventdata, handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% thuc thi khi tao doi tuong, sau khi thiet lap cac thuoc tinh.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Them tu moi vao tu dien

function pushbutton1_Callback(hObject, eventdata, handles)

global selected_col;
global selected_ln;
global all_img_1;
global all_img_2;
global all_img_3;
global all_img_4;
global all_words;
new_word = get(handles.edit1,'string');
if size(new_word,2) > 0 
    try
        trimg = handles.S;
        Ibox = preprocess(trimg);
        % Nguong
        trimg = rgb2gray(trimg);
        trimg = im2bw(trimg,graythresh(trimg));
        for cnt = 1:size(Ibox,2)
            rectangle('position',Ibox(:,cnt),'edgecolor','r');
            img{cnt} = imcrop(trimg,Ibox(:,cnt));
        end
        % loi khi nhan dien qua 4 tu
        if selected_ln ~= size(img,2)/selected_col
            Error_more_than_4_words;
        else 
            all_img_1{size(all_img_1,2)+1} = img{1};
            all_img_2{size(all_img_2,2)+1} = img{2};
            all_img_3{size(all_img_3,2)+1} = img{3};
            all_img_4{size(all_img_4,2)+1} = img{4};
            all_words{size(all_words,2)+1} = {new_word};
            %Them tu thanh cong
            set(handles.edit1, 'string','');
            wrod_successfully_added;
        end
    catch ME
        Error_no_word;
    end
else
    Error_no_word;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function pushbutton2_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile({'*.bmp;*.jpg;*.gif;*.png';'*.*'}, 'Anh co trong file','Dictionary/');
if pathname ~= 0
    S = imread([pathname,filename]);
    axes(handles.axes1);
    imshow(S);
    handles.S = S;
    guidata(hObject, handles);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pushbutton3_Callback(hObject, eventdata, handles)

global selected_ln;
global all_img_1;
global all_img_2;
global all_img_3;
global all_img_4;
global all_words;
counter = 1;
out = [];
for cnt = 1:size(all_img_1,2);
    bw2 = charcrop(all_img_1{cnt});
    charvec = figresize(bw2);
    out(:,counter) = charvec;
    counter = counter +1;
end
for cnt = 1:size(all_img_2,2);
    bw2 = charcrop(all_img_2{cnt});
    charvec = figresize(bw2);
    out(:,counter) = charvec;
    counter = counter +1;
end
for cnt = 1:size(all_img_3,2);
    bw2 = charcrop(all_img_3{cnt});
    charvec = figresize(bw2);
    out(:,counter) = charvec;
    counter = counter +1;
end
for cnt = 1:size(all_img_4,2);
    bw2 = charcrop(all_img_4{cnt});
    charvec = figresize(bw2);
    out(:,counter) = charvec;
    counter = counter +1;
end

if size(out,2) > 0
    P = out(:,1:size(all_img_1,2)*selected_ln); 
    T = [];
    for xxx = 1:selected_ln
        T = [T eye(size(all_img_1,2))];
    end
    %% tao mang neural
    net = createnn(P,T);
    handles.net = net;
    %% kiem tra mang neural
    assignin('base','net',net);
    %%----------------Training ANN
    guidata(hObject, handles);
    %save NN ALL
    save('DataBase.mat','net','all_img_1','all_img_2','all_img_3','all_img_4','all_words','-mat');
    clear;
    clear global;
    close;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initalizer Function - tai tu hinh anh

function figure1_CreateFcn(hObject, eventdata, handles)

movegui(hObject,'center');
set(hObject,'Name','Dao tao mang luoi than kinh');
clear;
clear global;
global selected_col;
selected_col = 1;
global selected_ln;
selected_ln = 4;
global all_img_1;
global all_img_2;
global all_img_3;
global all_img_4;
global all_words;
if exist('DataBase.mat','file') == 2
    saved_items = load('DataBase.mat','-mat');
    all_img_1 = saved_items.all_img_1;
    all_img_2 = saved_items.all_img_2;
    all_img_3 = saved_items.all_img_3;
    all_img_4 = saved_items.all_img_4;
    all_words = saved_items.all_words;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hien thi tat cac hinh anh trong tu dien
function pushbutton5_Callback(hObject, eventdata, handles)

global all_words;
if size(all_words,2) > 0
    fid = fopen('Words_Dictionary.txt', 'w', 'n', 'UTF-8');
    for i = 1:size(all_words,2)
        str = char(all_words{i});
        fwrite(fid, str, 'char');
        str1 = char(13);
        fwrite(fid, str1, 'char');
        str2 = char(10);
        fwrite(fid, str2, 'char');
    end
    fclose(fid);
    dos('notepad Words_Dictionary.txt &');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
