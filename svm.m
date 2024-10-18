for i = 1 : 75
    P(:,i) = facedet(['D:\Data\Face' int2str(i) '.tiff']);
end
P = double(P);
x=1;
y=1;
fid = fopen('example.txt','wt');
for i = 1 : 15
    for k = 1 : 5
    fprintf(fid,'%d',k);
    for j = 1 : 256
        fprintf(fid,' %d:',j);
        fprintf(fid,'%f',P(j,x));
    end
    fprintf(fid,'\n');
    end
   x = x +1;
end
fclose(fid);
for i = 1 : 25
    A(:,i)= facedet(['D:\Test\face' int2str(i) '.tiff']);
end
fid1 = fopen('test.txt','wt');
for i = 1: 5
    for k = 1 : 5
    fprintf(fid1,'%d',k);
    for j = 1 : 256
        fprintf(fid1,' %d:',j);
        fprintf(fid1,'%f',A(j,i));
    end
    fprintf(fid1,'\n');
    end
end
fclose(fid1);
