function shape1(ref_img,query  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
I1=query;
I1=rgb2gray(I1);
b1=edge(I1,'canny');
[nr nc]=size(I1);
rad = 24;
[y0detect,x0detect,Accumulator] = houghcircle(b1,rad,rad*pi);
res=zeros(1,length(ref_img));

for m=1:length(ref_img)
    display(ref_img{m});
    %c=strcat(a,ref_img{m});
I2=imread(ref_img{m});
I2=rgb2gray(I2);
%b1=edge(I1,'prewitt');
%[nr nc]=size(I1);
I2=imresize(I2,[nr nc]);
b2=edge(I2,'canny');
[y0detect1,x0detect1,Accumulator1] = houghcircle(b2,rad,rad*pi);
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
res(m)=count1/count;

end
rank_SIFT2(ref_img,res,I1);
end

