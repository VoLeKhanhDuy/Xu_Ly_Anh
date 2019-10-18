function re = XoaBit(p,n,m)
    for i = n : m
        p = bitset(p,i,0);
    end
    re = p;
end
