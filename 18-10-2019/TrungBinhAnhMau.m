I = imread('lena.jpg');
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
n=1;
m=5;

[d, c]=size(R);
for i=1:3:d/3*3
    for j=1:3:c/3*3
        R(i:i+2, j:j+2)=TrungBinhAnh(R(i:i+2, j:j+2));
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
