%Them anh vao
I = imread('lena.jpg');

%Xuat anh 
%imshow(I);


I1 = I(:,:,1);
I2 = I(:,:,2);
I3 = I(:,:,3);
%imshow(I1);

%Xuat nhieu anh, neu co 4 anh (2,2,..), neu co 6 anh (3,3,..)
% subplot(3,3,1);
% imshow(I);

% subplot(3,3,2);
% imshow('meo.jpg');
% 
% subplot(3,3,3);
% imshow('meo.jpg');
% 
% subplot(3,3,4);
% imshow('meo.jpg');
% 
% subplot(3,3,5);
% imshow('meo.jpg');
% 
% subplot(3,3,6);
% imshow('meo.jpg');

Inew = I;
XuLy = Inew(:,:,1);
[soDong,soCot] = size(XuLy);
doSangCongThem = 100;

subplot(2,1,1);
imshow(Inew);


for i = 1 : soDong
    for j = 1 : soCot
        XuLy(i,j) = XuLy(i,j) + doSangCongThem;
    end
end

Inew(:,:,1) = XuLy; 
subplot(2,1,2);
imshow(Inew);    
        




