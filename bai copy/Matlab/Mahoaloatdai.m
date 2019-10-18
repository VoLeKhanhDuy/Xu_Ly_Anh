I=[0 0 0 1 1 
   1 0 0 0 0  
   1 0 0 1 1 
   0 0 0 0 1  
   0 0 0 1 1];
count=0;        
dong =0;
cot1=1;
cot2=2;
value=0;
code =zeros;
[d, c]=size(I);
for i=1:d
    for j=1:c
        
        if(i==1 && j==1)
            count=1;
        elseif I(i,j)==value
                count=count+1;
            else
                
                 value=I(i,j);
                 count=1;   
        end
    end
end
  
dong=dong+1; 
code(dong, cot1)=count;
code(dong, cot2)=value;
