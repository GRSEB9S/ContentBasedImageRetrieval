% Example 3, Affine registration
% Load images
d=dir('C:\Users\abhishek\Desktop\SIFT_and _SURF\*.jpg');
abhi=cell(1,length(d));
for i=1:length(d)
    abhi{i}=d(i).name;
    files{i}=d(i).name;
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
ipts_db=cell(1,length(d));
for i=1:length(d)
    I2=imread(abhi{i});
    image_s=size(I2);
    im_size{i}=image_s;
    
    display(abhi{i});
    %display(size(a));
    %I2=imresize(I2,[nr nc]);


    Ipts2=OpenSurf(I2,Options);
    ipts_db{i}=Ipts2;
% Put the landmark descriptors in a matrix



end
 save('model1','ipts_db','im_size','files')
