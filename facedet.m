function[finalop] = facedet(a)
dwtmode('zpd');
a = double(imread(a));
imshow(uint8(a))

sizea=size(a);
[c,s]=  wavedec2(a,4,'haar');
sizec=size(c);
h_cf2 = detcoef2('h',c,s,4); 

[m,n]=size(h_cf2);       

sizehcf=size(h_cf2);
%h_cf2=imresize(h_cf2,[100,100]);
LH1=zeros(m*n,1);         
k=1;
for i=1:m  
    for j=1:n
        LH1(k)= abs(h_cf2(i,j));     
        k=k+1;
    en
end
   LH=sort(LH1,'descend');                  
ln=25;
max_pk=zeros(ln,1);
for i=1:ln
    max_pk(i)=LH(i);                                      
end
dhcf2=zeros(m,n);
for i=1:m
    for j=1:n
        if any(abs(h_cf2(i,j))>=max_pk)    
            dhcf2(i,j)=h_cf2(i,j);                                             
        end
    end
end
%dhcf2= imresize(dhcf2,[100,100]);
  inp=zeros(ln,13);
   size(inp)
   l=1;k=1;
   ph_cf2=[zeros(1,n+2);zeros(m,1),h_cf2,zeros(m,1);zeros(1,n+2)];    
   pdhcf2=[zeros(1,n+2);zeros(m,1),dhcf2,zeros(m,1);zeros(1,n+2)];          
   [size_LHx,size_LHy]=size(h_cf2);
   
   for i=2:m+1
      for j=2:n+1
        if dhcf2(i-1,j-1)~=0 
            pdhcf2(i-1,j-1)=ph_cf2(i-1,j-1); 
            pdhcf2(i-1,j) =ph_cf2(i-1,j);        
            pdhcf2(i-1,j+1)=ph_cf2(i-1,j+1);
            pdhcf2(i,j-1)=ph_cf2(i,j-1);                          
            pdhcf2(i,j)=ph_cf2(i,j);       
            pdhcf2(i,j+1)=ph_cf2(i,j+1);
            pdhcf2(i+1,j-1)=ph_cf2(i+1,j-1);                  
            pdhcf2(i+1,j)=ph_cf2(i+1,j);  
            pdhcf2(i+1,j+1)=ph_cf2(i+1,j+1);
            inp(l,k)=ph_cf2(i-1,j-1);              
            inp(l,k+1)=ph_cf2(i-1,j);      
            inp(l,k+2)=ph_cf2(i-1,j+1); 
            inp(l,k+3)=ph_cf2(i,j-1);                      
            inp(l,k+4)=ph_cf2(i,j);     
            inp(l,k+5)=ph_cf2(i,j+1);
            inp(l,k+6)=ph_cf2(i+1,j-1);                  
            inp(l,k+7)=ph_cf2(i+1,j);   
            inp(l,k+8)=ph_cf2(i+1,j+1);
%           inp(l,k+10)=i-1/size_LHx ;       
            inp(l,k+9)=j-1/size_LHy;
            inp(l,k+10)=i-1;      
            inp(l,k+9)=j-1;
             l=l+1;     k=1;
                   
        end
      end
   end
   inp(:,10:11)

 
   for i=1:m
    for j=1:n
        xdhcf2(i,j)=pdhcf2(i+1,j+1);
    end
   end
   %xdhcf2=imresize((xdhcf2),[100,100]);
  
   for i= 1 : 16
       for j = 1:16
           xdhcf2(i,j) = double(255)-xdhcf2(i,j);
       end
   end
    %imview(imresize(xdhcf2,[100,100]));
    finalop = imresize(xdhcf2,[1,256]);
