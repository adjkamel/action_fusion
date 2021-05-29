function res=drawskt(file,tline)


B=[];
       fp=fopen(file,'r'); 
       A=fscanf(fp,'%f');
       B=[B; A];
       fclose(fp);

l=size(B,1)/4;
D=reshape(B,4,l);
B=D;
B=B';
B=reshape(B,20,l/20,4);

X = B(:,:,1);
Z = B(:,:,2); %%%%%%%%%% order changed ok
Y = B(:,:,3);
P = B(:,:,4);

folderskel='datasetskel\'; 

jointrep =zeros(12,size(X,2),3);

jointe =zeros(112,112);
k=1;

for i=1:size(X,2)
    
  
     
    
         
       % k=1;
  
           % jointprev=[X(:,i-10) Y(:,i-10) Z(:,i-10)];
            %jointprev=jointprev./max(max(jointprev));
            joint=[X(:,i) Y(:,i) Z(:,i)];
            
          %  joint=joint./max(max(joint));

            %for j=1:19 % we define them
                    %%%%%%%%%%%% same order as mahd 
                     %if  ((j~=3)||(j~=8)||(j~=12)||(j~=16)||(j~=20)) we
                     %define them
                    
                    
                                         
                     
             [jointrep(1,i,1),jointrep(1,i,2),jointrep(1,i,3)] =  cart2sph( joint(17,1)-joint(7,1)    , joint(17,2)-joint(7,2)  , joint(17,3)-joint(7,3));  
              [jointrep(2,i,1),jointrep(2,i,2),jointrep(2,i,3)] =  cart2sph( joint(15,1)-joint(7,1)    , joint(15,2)-joint(7,2)  , joint(15,3)-joint(7,3)); 
               [jointrep(3,i,1),jointrep(3,i,2),jointrep(3,i,3)] =  cart2sph( joint(6,1)-joint(7,1)    , joint(6,2)-joint(7,2)  , joint(6,3)-joint(7,3)); 
               
                [jointrep(4,i,1),jointrep(4,i,2),jointrep(4,i,3)] =  cart2sph( joint(16,1)-joint(7,1)    , joint(16,2)-joint(7,2)  , joint(16,3)-joint(7,3)); 
                 [jointrep(5,i,1),jointrep(5,i,2),jointrep(5,i,3)] =  cart2sph( joint(14,1)-joint(7,1)    , joint(14,2)-joint(7,2)  , joint(14,3)-joint(7,3)); 
                  [jointrep(6,i,1),jointrep(6,i,2),jointrep(6,i,3)] =  cart2sph( joint(5,1)-joint(7,1)    , joint(5,2)-joint(7,2)  , joint(5,3)-joint(7,3)); 
                  
                   [jointrep(7,i,1),jointrep(7,i,2),jointrep(7,i,3)] =  cart2sph( joint(11,1)-joint(7,1)    , joint(11,2)-joint(7,2)  , joint(11,3)-joint(7,3)); 
                    [jointrep(8,i,1),jointrep(8,i,2),jointrep(8,i,3)] =  cart2sph( joint(9,1)-joint(7,1)    , joint(9,2)-joint(7,2)  , joint(9,3)-joint(7,3)); 
                     [jointrep(9,i,1),jointrep(9,i,2),jointrep(9,i,3)] =  cart2sph( joint(2,1)-joint(7,1)    , joint(2,2)-joint(7,2)  , joint(2,3)-joint(7,3)); 
                     
                      [jointrep(10,i,1),jointrep(10,i,2),jointrep(10,i,3)] =  cart2sph( joint(10,1)-joint(7,1)    , joint(10,2)-joint(7,2)  , joint(10,3)-joint(7,3)); 
                       [jointrep(11,i,1),jointrep(11,i,2),jointrep(11,i,3)] =  cart2sph( joint(8,1)-joint(7,1)    , joint(8,2)-joint(7,2)  , joint(8,3)-joint(7,3)); 
                        [jointrep(12,i,1),jointrep(12,i,2),jointrep(12,i,3)] =  cart2sph( joint(1,1)-joint(7,1)    , joint(1,2)-joint(7,2)  , joint(1,3)-joint(7,3)); 
                        
                        
               k=k+1;
               
                      % i-10 because the first fram is not exist
                     % k=k+1;
                     %end

            %end    
    
end

jointrep(:,:,1)=mat2gray(jointrep(:,:,1));
jointrep(:,:,2)=mat2gray(jointrep(:,:,2));
jointrep(:,:,3)=mat2gray(jointrep(:,:,3));






I=cat(3, jointrep(:,:,1),  jointrep(:,:,2),  jointrep(:,:,3));





%I = imnoise(I,'gaussian');

%sigma = 2;

%smoothImage = imgaussfilt(I,sigma);

%I = imgradient(smoothImage,'CentralDifference');






image_size = [112 112];

I=imresize(I,image_size);




      opBaseFileName = sprintf('%s.png', tline);
      opFullFileName = fullfile(folderskel, opBaseFileName);
      imwrite(I,opFullFileName);
      