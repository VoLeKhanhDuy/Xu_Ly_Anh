% I=imread('8-bit-256-x-256-Grayscale-Lena-Image.png');
% I=rgb2gray(I);

I=[1 1 1;2 2 3;4 1 1];

danhsach_tk= thongke(I,256);

danhsach_sort=sortrows(danhsach_tk,2);
%thêm cot 3 và 4 v?i giá tr? 0
danhsach_sort(:,3)=0;
danhsach_sort(:,4)=0;
i=2;
tenpt=1;
tansuat=2;
level=3;
name_pt  = max(danhsach_sort(:,1))+1;%tao ten cho phan tu m?i
[d,c]=size(danhsach_sort);
while  sum(danhsach_sort(:,level)==0) > 2 && i<d
    %sap xep lai
    danhsach_sort=sortrows(danhsach_sort,2);
    %nhom 2 phan tu 
    %tinh tan suat cuar pt moi
    val_tansuat=danhsach_sort(i,tansuat)+danhsach_sort(i-1,tansuat);
    d=d+1;
    danhsach_sort(d,tenpt)=name_pt;
    danhsach_sort(d,tansuat)=val_tansuat;
    danhsach_sort(d,level)=0;
    %hai pt co tan suat thap nhat la con cua phan tu moi
    danhsach_sort(i,level)=name_pt;
    danhsach_sort(i-1,level)=name_pt;
    name_pt=name_pt+1;
    i=i+2;
end 