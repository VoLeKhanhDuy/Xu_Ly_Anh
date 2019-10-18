function res=thongke(I,L)
l=1;
for i=0:L-1
    val=sum(I(:) == i);
    if val~=0
        res(l,1)=i;
        res(l,2)=val;
        l=l+1;
    end
end
end