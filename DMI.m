function show_depth(depth,k)

num_frame = size(depth,3);

folder='dataset\';     d = dir('dataset\*.png');
folder2='dataset2\';   d2 = dir('dataset2\*.png');
folder3='dataset3\';   d3 = dir('dataset3\*.png');
folder4='dataset4\';   d4 = dir('dataset4\*.png');
folder5='dataset5\';   d5= dir('dataset5\*.png');



delete('F:\ActionRecognition\UTD\Sample_Code\dataset\*.png');
delete('F:\ActionRecognition\UTD\Sample_Code\dataset2\*.png');




for i = 1:num_frame
    
      I=mat2gray(depth(:,:,i));
      originalMinValue = single(min(min(I)));  
      originalMaxValue = single(max(max(I)));
      originalRange = originalMaxValue - originalMinValue;  
      desiredMin = 0;
      desiredMax = 1;
      desiredRange = desiredMax - desiredMin;
     I = desiredRange * (single(I) - originalMinValue) /originalRange + desiredMin;
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% I = I./ max(I(:)) ;
      
      opBaseFileName = sprintf('%d.png', i);
      opFullFileName = fullfile(folder, opBaseFileName);
      imwrite(I,opFullFileName,'png');
      
      I= im2bw(I);
      opBaseFileName = sprintf('%d.png', i);
      opFullFileName = fullfile(folder2, opBaseFileName);
      imwrite(I,opFullFileName,'png');
                     
end

delete('F:\ActionRecognition\UTD\Sample_Code\dataset3\*.png');

 d = dir('dataset\*.png');
 
for i = 1 : length(d)
    
    if i>1    
        
      filename1 = strcat('dataset\',int2str(i-1),'.png');
      
      pre = imread(filename1);
      
      filename2 = strcat('dataset\',int2str(i),'.png');

      curr = imread(filename2);
      
      bindiff=(curr-pre); 
      
      opBaseFileName = sprintf('%d.png',i-1); 
      
      opFullFileName = fullfile(folder3, opBaseFileName);
      
      imwrite(bindiff,opFullFileName,'png');
      
    end 
    
end



      
      






delete('F:\ActionRecognition\UTD\Sample_Code\dataset4\*.png');

IMH=zeros(240,320);
IMHprev=zeros(240,320);

      d = dir('dataset\*.png');
      d3 = dir('dataset3\*.png');
      d4 = dir('dataset4\*.png');
        
alpha=(256/length(d3))-1;


for i = 1 : length(d3)

      
       dep = strcat('dataset\',int2str(i),'.png');
       dep = imread(dep);
       
       depin = strcat('dataset\',int2str(1),'.png');
       depin = imread(depin);
       depin = strcat('dataset\',int2str(2),'.png');
       depin = imread(depin2);
       
       bindiff = strcat('dataset3\',int2str(i),'.png');
       bindiff = imread( bindiff);
       

       
       if i==1
              IMHprev= bindiff; 
              
       else
              IMHprev = strcat('dataset4\',int2str(i-1),'.png');
              IMHprev = imread(IMHprev);
       end
       
      
         
       
        for m=1 : 240
    
          for l=1 : 320

             if bindiff(m,l)==1
                 
                  IMH(m,l)=alpha;
                  
             else        
                 
                  IMH(m,l)=max(0,IMHprev(m,l)-1);
                  
             end 
             
           
          end
    
        end 
        
     IMH=mat2gray(IMH);
     opBaseFileName = sprintf('%d.png',i);
     opFullFileName = fullfile(folder4, opBaseFileName);
     imwrite(IMH,opFullFileName,'png');
      
end

    
     
%{

      filename6 = strcat('dataset3\',int2str(1),'.png');
      img = imread(filename6);
      fi=img;
      
      d3 = dir('dataset3\*.png');

      for i = 2 : length(d3)
      filename7 = strcat('dataset3\',int2str(i),'.png');
      img = imread(filename7);
      fi=fi+img;     
      end
      
      opBaseFileName = sprintf('%d.png', k);
      opFullFileName = fullfile(folder5, opBaseFileName);
      imwrite(fi,opFullFileName,'png');

%}

