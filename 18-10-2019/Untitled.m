%Them anh vao
I = imread('lena.jpg');


R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
n=1;
m=5;
[d, c] = size(R);
for i=1:d
    for j=1:c
        R(i,j)=XoaBit(R(i,j),n,m);
        G(i,j)=XoaBit(G(i,j),n,m);
        B(i,j)=XoaBit(B(i,j),n,m);
    end
end


Inew = I;
Inew(:,:,1)=R;
Inew(:,:,2)=G;
Inew(:,:,3)=B;

subplot(2,2,1);
imshow(I);
subplot(2,2,2);
imshow(Inew);



