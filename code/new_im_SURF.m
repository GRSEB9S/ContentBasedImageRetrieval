src=load('model1');
display('before loading');
src
len=length(src.files);
% Example 3, Affine registration
% Load images
d=dir('C:\Users\abhishek\Desktop\SIFT_and _SURF\new_im\*.jpg');
abhi=cell(1,length(d));
for i=1:length(d)
    abhi{i}=d(i).name;
 %   files{i}=d(i).name;
end
%I1=imread('t1.jpg');
%I2=im2double(imread('TestImages/lena2.png'));
%image_s=size(I1);
%nr=image_s(1);
%nc=image_s(2);
% Get the Key Points
Options.upright=true;
Options.tresh=0.0001;
%Ipts1=OpenSurf(I1,Options);
%ipts_db=cell(1,length(d));
strtn=1;
for i=len:len+length(d)-1
    I2=imread(abhi{strtn});
    image_s=size(I2);
    im_size{i+1}=image_s;
    files{i+1}=abhi{strtn};
    display(abhi{i});
    %display(size(a));
    %I2=imresize(I2,[nr nc]);
    Ipts2=OpenSurf(I2,Options);
    ipts_db{i+1}=Ipts2;
% Put the landmark descriptors in a matrix
    strtn=strtn+1;


end
 save('model1','ipts_db','im_size','files')
src=load('model1');
display('After loading');
src
