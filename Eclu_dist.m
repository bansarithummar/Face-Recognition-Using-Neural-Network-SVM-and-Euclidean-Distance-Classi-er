im = facedet('D:\Data1\face1.pgm');
H=size(im,1); %Height of the images
    W=size(im,2); %Width of the images
   % M=size(pgmFiles,1); %Number of images in the training set
 images=zeros(H,W,75);
    vec=zeros(H*W,75);

    % load the training images
    for i=1:75
        images(:,:,i)=facedet(['D:\Data1\face' int2str(i) '.pgm']);
        vec(:,i)=reshape(images(:,:,i),H*W,1);
    en
        
    % mean face
    m=sum(vec,2)/75;

    % face space
    A=vec-repmat(m,1,75);

    L=A'*A;
    [V,lambda]=eig(L);

    % eigenvector of the covariance matrix of A. These are the eigenfaces
    U=A*V;

    % projection of each vector in the face space A on the eigenfaces
    omega=U'*A;
    
  for k = 1: 25  
    testIm=facedet(['D:\Data1\face' int2str(i) '.pgm']);
     %testImage = imread('D:\Test\face1.tiff')   
    im1=reshape(testIm,H*W,1);
    imtest=double(im1);
    
    imd=imtest-m;
    
    % projection of the test face on the eigenfaces
    om=U'*imd;

    d=repmat(om,1,75)-omega;
    
    dist=zeros(75,1);
     
    % find the distance from all training faces
    for i=1:75
        dist(i,1)=norm(d(:,i));
    end

    % index corresponding to the minimum of the distances
    index(:,k)=IndexOfMinimum(dist);
  end 
%     % display the results
%     subplot(1,2,1)
%     imshow(testImage)
%     title('Test face')
%     subplot(1,2,2)
%     imshow(uint8(images(:,:,index)))
%     title('Recognized face')
