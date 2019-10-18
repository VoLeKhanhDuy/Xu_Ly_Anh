function I=DecodeRLC(code,n)

Cot1=1;
Cot2=2;
[d,c]=size(code);
l=1;
for i=1:d
    value=code(i,Cot2);
    count=code(i,Cot1);
    for j=1:count
        M(l)=value;
        l=l+1;
    end
end
I=vec2mat(M,n);
end


