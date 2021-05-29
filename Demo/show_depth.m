function show_depth(depth,ax)

num_frame = size(depth,3);

for i = 1:num_frame
    
      I=mat2gray(depth(:,:,i));
     
     imshow(I,'Parent', ax);
    pause(1/200);
end