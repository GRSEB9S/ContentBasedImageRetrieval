d=dir('*.jpg');
abhi=cell(1,length(d));
for i=1:length(d)
    abhi{i}=d(i).name;
end
img = imread('r1.jpg');
       img=rgb2gray(img);
       imgBW = edge(img,'canny');
      rad = 24;
      [nc nr]=size(img);
       [y0detect,x0detect,Accumulator] = houghcircle(imgBW,rad,rad*pi);
for k=1:length(d)
       img1= imread(abhi{k});
img1=imresize(img1,[nc nr]);       
img1=rgb2gray(img1);
       imgBW1 = edge(img1,'canny');
  [y0detect1,x0detect1,Accumulator1] = houghcircle(imgBW1,rad,rad*pi);
count=0;
count1=0;
 for i=1:nc
     for j=1:nr
         if (Accumulator(i,j)>=1)
             count=count+1;
         end
     end
 end
 for i=1:nc
     for j=1:nr
         if ((Accumulator(i,j)==Accumulator1(i,j)| abs(Accumulator(i,j)-Accumulator1(i,j))<=2 )>=1)
             count1=count1+1;
         end
     end
 end
 abhi{k}
 s=count1/count
 end
 