
function list=run(act,ind,ax1,ax2,ax3,ax4)



disp(act);



load(strcat('Depth\',act,'_depth.mat'));

show_depth(d_depth,ax1);

load(strcat('Skeleton\',act,'_skeleton.mat'));
axes(ax2)
show_joint_3D(d_skel,ax2);

imdpth=imread(strcat('testD\',act,'_depth.png'));
imsklt=imread(strcat('testS\',act,'_skeleton.png'));

imshow(imdpth, 'Parent', ax3);
imshow(imsklt, 'Parent', ax4);


load('action.mat');

list= Matrix1(ind,2:28);


%axes(handles.axes54);

%imshow(yourImage);



end
