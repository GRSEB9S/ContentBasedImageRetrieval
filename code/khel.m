function khel(ref_img,query)
%a='C:\Users\akshay\Desktop\project implementation\SIFT_and _SURF\';

I1=query;
I1=rgb2gray(I1);
b1=edge(I1,'prewitt');
[nr nc]=size(I1);
rad = 24;
[y0detect,x0detect,Accumulator] = houghcircle(b1,rad,rad*pi);
%res=zeros(1,length(ref_img));

res=zeros(1,length(ref_img));
for m=1:length(ref_img)
    display(ref_img{m});
    %c=strcat(a,ref_img{m});
I2=imread(ref_img{m});
I2=rgb2gray(I2);
%b1=edge(I1,'prewitt');
%[nr nc]=size(I1);
I2=imresize(I2,[nr nc]);
b2=edge(I2,'prewitt');
[y0detect1,x0detect1,Accumulator1] = houghcircle(b2,rad,rad*pi);
count=0;
count1=0;
for j=1:nr
for k=1:nc
if(b1(j,k)==1 & Accumulator(j,k)>=1)
    count=count+1;
end
end
end

for j=1:nr
for k=1:nc
if((b1(j,k)==1) & (b2(j,k)==1 )&(abs(Accumulator(j,k)-Accumulator1(j,k))<=5) & Accumulator(j,k)>0 & Accumulator1(j,k)>0)
    count1=count1+1;
end
end
end
%count
%count1
res(m)=count1/count;

end
rank_SIFT1(ref_img,res,I1);