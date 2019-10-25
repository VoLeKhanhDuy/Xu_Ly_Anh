function index = index_3bit(r, g, b)
    ind_Lut = [0 0 0 ; 0 0 1 ; 0 1 0 ; 0 1 1 ; 1 0 0 ; 1 0 1 ; 1 1 0 ; 1 1 1]; 
    viTri = 1;
    for i = 1:length(ind_Lut)
        if(r == ind_Lut(i, 1) && g == ind_Lut(i, 2) && b == ind_Lut(i, 3))
            viTri = i;
        end
    end
    index = viTri;
end
