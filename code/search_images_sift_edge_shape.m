function search_images_sift_edge_shape(path)
%%

%clc;
%clear all;
%close all;

%sigma=3;
%a=imread('5.jpg');
% g=fspecial('gaussian',ceil(4*sigma),sigma);
% b=imfilter(a,g,'symmetric','conv');
display(path);
b=imread(path);
c=b;
keypnts_b=lowesift(b);
figure(2)
subplot(2,2,1);imshow(b);title('Searching Images...');        
image_s1=size(c);
nr1=image_s1(1);
nc1=image_s1(2);

source=load('model');
nsize=length(source.keypoints_finals);
result=zeros(1,nsize);
p=1;

for start=1:nsize

%image_size=size(a);
%b=imresize(a,0.5);
a1=source.files{start};
a1
keypnts_a=source.keypoints_finals{start};
a=imread(a1);
subplot(2,2,2);imshow(a);
title(a1);        
drawnow
image_s=size(a);
nr=image_s(1);
nc=image_s(2);
%if(~(nr == nr1 && nc==nc1))
    
%b=imresize(c,[nr nc]);


%else
%keypnts_b=lowesift(c);
%end
im=appendimages(a,b);
%display('1st');
%keypnts_a=lowesift(a);
%keypnts_b=lowesift(b);
%display('2nd');
%Keypnts_b are of the test image
%display('3rd');
%figure,imshow(im);
hold on;
count=0;
for i=1:length(keypnts_b)
    
   [x,y,sort_fin]= knne(keypnts_a,keypnts_b(i,:));
   
   
   x1=keypnts_b(i,1);
   y1=keypnts_b(i,2);
   
   if(sort_fin(1,1)<70)
       count=count+1;
   line([x,x1+nc],[y,y1]);
   end
 end
  hold off;
%   clc;
%  count
%  a1
  count/length(keypnts_b)
  result(p)=count/length(keypnts_b);p=p+1;
 % if(count/length(keypnts_b)>0.75)
  %    display('IMAGE MATCHED ,GO HOME');
   
 % else
  %    display('not matched');
  %end

end
rank_SIFT11(result,path);
end