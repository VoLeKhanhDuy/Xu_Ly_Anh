function varargout = OCR_Window(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OCR_Window_OpeningFcn, ...
                   'gui_OutputFcn',  @OCR_Window_OutputFcn, ...
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
% hien thi OCR.
function OCR_Window_OpeningFcn(hObject, eventdata, handles, varargin)
% hObject: xu ly hinh anh
% eventdata: xac dinh phien ban matlab
% handles    xu ly cau truc va du lieu nguoi dung ( GUIDATA)
% varargin   doi so dong lenh den OCR_Window (VARARGIN)
set(hObject,'Name','Arabic OCR Project');
movegui(hObject,'center');
global net;
global all_words;
if exist('DataBase.mat','file') == 2
    saved_items = load('DataBase.mat','-mat');
    all_words = saved_items.all_words;
    net = saved_items.net;
else
    error_no_nn_exist;
end
% chon dau ra cho OCR_Window

handles.output = hObject;
guidata(hObject, handles);


% ( UIRESUME)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% dau ra cua ham dc tra ve dong lenh.
function varargout = OCR_Window_OutputFcn(hObject, eventdata, handles) 


% nhan dau ra
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% thuc hien khi bam nut lua chon anh.
function pushbutton1_Callback(hObject, eventdata, handles)

[filename, pathname] = uigetfile({'*.bmp;*.jpg;*.gif;*.png';'*.*'}, 'Anh co trong file','Tests/');
if pathname ~= 0
    S = imread([pathname,filename]);
    axes(handles.axes1);
    imshow(S);
    handles.S = S;
    guidata(hObject, handles);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% bam nut vao xu ly.
function pushbutton2_Callback(hObject, eventdata, handles)


global net;
global all_words;
try
    I = handles.S;
    %Threshold
    Igray = rgb2gray(I);
    Ibw = im2bw(Igray,graythresh(Igray));
    Iedge = edge(uint8(Ibw));
    %--------------------------------
    se = strel('Line',25,0);
    se1 = strel('Line',20,90);
    Iedge2 = imdilate(Iedge, se); 
    Iedge3 = imdilate(Iedge2, se1);
    Ifill = imfill(Iedge3,'holes');
    [Ilabel num] = bwlabel(Ifill);
    Iprops = regionprops(Ilabel);
    Ibox = [Iprops.BoundingBox];
    [y,x]=size(Ibox);
    x=x/4;
    Ibox = reshape(Ibox,[4 x]);
    
    Fbox = [];
    line = [];
    counter = 0;
    for qq =1:size(Ibox,2)
        Tbox = [];
        min = 1024;
        avg_height = 0;
        for j = 1:size(Ibox,2)
            if min > Ibox(2,j)
                min = Ibox(2,j);
                counter = counter + 1;
            end
            avg_height = avg_height + Ibox(4,j);
        end
        avg_height = avg_height / size(Ibox,2);

        for j = 1:size(Ibox,2)
            if abs(min - Ibox(2,j)) < avg_height
                Tbox = [Tbox Ibox(:,j)];
                line = [line counter];
                Ibox(2,j) = 2024;
            end
        end
        if size(Tbox,1) > 0
            Tbox = sortrows(Tbox',-1)';
            Fbox = [Fbox Tbox];
        end
    end
    Ibox = Fbox;
    fid = fopen('Arabic_output.txt', 'w', 'n', 'UTF-8');
    current_line = line(1);
    for cnt = 1:size(Ibox,2)
        rectangle('position',Ibox(:,cnt),'edgecolor','r');
        img{cnt} = imcrop(Ibw,Ibox(:,cnt));
        %tien xu ly
        bw2 = charcrop(img{cnt});
        %------------
        %khai thac tinh nang
        charvec = figresize(bw2);
        %------------
        % xac nhan
        result = sim(net,charvec);
        if sum(ones(size(result))-result<=0.05) == 1 && sum(result >= 0.1) == 1 %<=0.05 ; >=0.2 ==1 0.04 0.09
            [val, num] = max(result);
            str = char(all_words{num});
        else
            str = '?';
        end
        if current_line == line(cnt)
            fwrite(fid,' ', 'char');
        else
            str1 = char(13);
            fwrite(fid, str1, 'char');
            str2 = char(10);
            fwrite(fid, str2, 'char');
            current_line = line(cnt);
        end
        fwrite(fid, str, 'char');
        
        %------------
    end
    fclose(fid);
    dos('notepad Arabic_output.txt &');
    guidata(hObject, handles);
catch ME
    Error_no_word;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
