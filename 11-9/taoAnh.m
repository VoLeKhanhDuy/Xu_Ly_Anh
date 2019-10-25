function kq = taoAnh(red, green, blue, row, col)

    %Tao mang
    Red = zeros (row, col);
    Green = zeros (row, col);
    Blue = zeros (row, col);
    
    %Cong gia tri truyen vao
    Red = Red + red;
    Green = Green + green;
    Blue = Blue + blue;
    
    %Tao anh
    I = zeros (row, col, 3);
    
    I(:,:,1) = Red;
    I(:,:,2) = Green;
    I(:,:,3) = Blue;
    
    %Ep kieu unit8
    kq = uint8(I);
    

end

