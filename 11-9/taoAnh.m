function kq = taoAnh(red, green, blue, row, col)

    %T?o m?ng
    Red = zeros (row, col);
    Green = zeros (row, col);
    Blue = zeros (row, col);
    
    %C?ng gi� tr? truy?n v�o
    Red = Red + red;
    Green = Green + green;
    Blue = Blue + blue;
    
    %T?o ?nh
    I = zeros (row, col, 3);
    
    I(:,:,1) = Red;
    I(:,:,2) = Green;
    I(:,:,3) = Blue;
    
    %�p ki?u unit8
    kq = uint8(I);
    

end

