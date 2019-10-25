I = imread('lena.jpg');

I1 = I;
I2 = I;
I3 = I;

[soDong, soCot] = size(I(:,:,1));

    for i=1:soDong
        for j=1:2:soCot
            if(j+1 > soCot)
                break;
            else
                avg = (int16(I1(i,j)) + int16(I1(i,j+1))) / 2;
                I1(i,j)     = avg;
                I1(i,j+1)   = avg;
            end
        end
    end
    
I4 = I(:,:,1);
                


