
%function keypoints_final=lowesift(image)

Jpegfile=dir('*.jpg');
number1=length(Jpegfile);
%a='C:\Users\abhishek\Desktop\SIFT_and _SURF\';
keypoints_finals=cell(1,number1);
files=cell(1,number1);
for start=1:number1
im = Jpegfile(start).name
image=imread(im);
%image2=imread('johnny.jpg');
%image=appendimages(image1,image2);
temp=image;%temp is the copy of the orignal image
image_size=size(temp);

%convert the rgb image to grayscale image
if(image_size(3)==3)
image_gray=rgb2gray(temp);
else
    image_gray=temp;
end

%converting the temp into floating image i.e from 0 to 1 
 [nrows ncols]=size(image_gray);
 image_gray=double(image_gray);
 for r=1:nrows
     for c=1:ncols
    image_gray(r,c)=image_gray(r,c)/255;  
     end
 end

 
 %%
 %smoothing the image with sigma value of 0.5
 g=fspecial('gaussian',ceil(4*0.5),0.5);
 image_gray=imfilter(image_gray,g,'symmetric','conv');

 %%double the dimension for getting stable keypoints
 image_gray_d=imresize(image_gray,2);
 
 %preblur the above image with sigma value of 1
  g=fspecial('gaussian',ceil(4*1),1);
 image_gray_d=imfilter(image_gray_d,g,'symmetric','conv');
 
 %%
 %Initialisations
 initsigma=sqrt(2);
 sig=zeros(4,5);
 image_cell=cell(4,5);%for saving all the octaves and corresponding scales of the images
 image_cell{1,1}=image_gray_d;
 dog_cell=cell(4,4);
 
 sig(1,1)=initsigma*0.5;
 
 for octave=1:4
     sigma=initsigma;
     for interval=2:5
        sigm_f=sigma;
        sigma=sqrt(2)*sigma;
        sig(octave,interval)=sigma*0.5*(2^(octave-1));
        g=fspecial('gaussian',ceil(4*sigm_f),sigm_f);
        image_cell{octave,interval}=imfilter(image_cell{octave,interval-1},g,'symmetric','conv');
        
        %dog
         dog_cell{octave,interval-1}= image_cell{octave,interval-1}- image_cell{octave,interval};
        
         
     end
      if(octave<4)
     image_cell{octave+1,1}=imresize(image_cell{octave,1},0.5);%resizing the image to half
     sig(octave+1,1)=sig(octave,3);
     end
 end


     
 %%
 %detect extrema(maxima/minima)
 image_extrema=cell(4,2);
 f=zeros(1,27);
 number_keypoint=0;
 reject=0;
 flag=0;
 
 
 for octave=1:4
     %display(octave);
     for interval=2:3
      %   display(interval);
         [nrows ncols]=size(dog_cell{octave,1});
         image_extrema{octave,interval-1}=zeros(nrows,ncols);
         
         for r=1:nrows
             
             for c=1:ncols
                flag=false;
                  if((r>1)&&(r<nrows)&&(c>1)&&(c<ncols))
                      
                 f(1)=dog_cell{octave,interval}(r,c);                      
                 f(2)=dog_cell{octave,interval-1}(r-1,c);
                 f(3)=dog_cell{octave,interval-1}(r-1,c-1);
                 f(4)=dog_cell{octave,interval-1}(r,c-1);
                 f(5)=dog_cell{octave,interval-1}(r+1,c-1);
                 f(6)=dog_cell{octave,interval-1}(r+1,c);
                 f(7)=dog_cell{octave,interval-1}(r+1,c+1);
                 f(8)=dog_cell{octave,interval-1}(r,c+1);
                 f(9)=dog_cell{octave,interval-1}(r-1,c+1);                               
                 f(10)=dog_cell{octave,interval}(r-1,c);
                 f(11)=dog_cell{octave,interval}(r-1,c-1);
                 f(12)=dog_cell{octave,interval}(r,c-1);
                 f(13)=dog_cell{octave,interval}(r+1,c-1);
                 f(14)=dog_cell{octave,interval}(r+1,c);
                 f(15)=dog_cell{octave,interval}(r+1,c+1);
                 f(16)=dog_cell{octave,interval}(r,c+1);
                 f(17)=dog_cell{octave,interval}(r-1,c+1);
                 f(18)=dog_cell{octave,interval+1}(r,c);
                 f(19)=dog_cell{octave,interval+1}(r-1,c);
                 f(20)=dog_cell{octave,interval+1}(r-1,c-1);
                 f(21)=dog_cell{octave,interval+1}(r,c-1);
                 f(22)=dog_cell{octave,interval+1}(r+1,c-1);
                 f(23)=dog_cell{octave,interval+1}(r+1,c);
                 f(24)=dog_cell{octave,interval+1}(r+1,c+1);
                 f(25)=dog_cell{octave,interval+1}(r,c+1);
                 f(26)=dog_cell{octave,interval+1}(r-1,c+1);                 
                 f(27)=dog_cell{octave,interval-1}(r,c);
                 
                     if(max(f)==dog_cell{octave,interval}(r,c))
                         image_extrema{octave,interval-1}(r,c)=255; 
                         number_keypoint=number_keypoint+1;
                        flag=true;
                        
                     end
                     if(min(f)==dog_cell{octave,interval}(r,c))
                         image_extrema{octave,interval-1}(r,c)=255;
                         number_keypoint=number_keypoint+1;
                       flag=true;
                        
                     end
                    
                     %Contrast Threshold
                     if(flag==true)
                         if(dog_cell{octave,interval}(r,c)<0.03)
                                 image_extrema{octave,interval-1}(r,c)=0;
                                 number_keypoint=number_keypoint-1;
                                 reject=reject+1; 

                         end
                         flag=false;
                     end
                     
                   
                 
                 
                 
                  end
                  
             end
         end
     end
 end
 
 %%
 %Assigning orientations
  %display('Step 4)Assigning orientations to the keypoints');
 image_magnitude=cell(4,2);%to store the magnitude of the points in the images
 image_orientation=cell(4,2);%to store the orientation of the points in the images
 
 for octave=1:4
     for interval=2:3
         [nrows ncols]=size(image_cell{octave,interval});
         image_magnitude{octave,interval-1}=zeros(nrows,ncols);
         image_orientation{octave,interval-1}=zeros(nrows,ncols);
         
         for r=2:nrows-1
             for c=2:ncols-1
                 
                 %%Calculate the gradient
                 dx=double(image_cell{octave,interval}(r+1,c)-image_cell{octave,interval}(r-1,c));
                 dy=double(image_cell{octave,interval}(r,c+1)-image_cell{octave,interval}(r,c-1));
                 
                 %%Store the magnitude
                 image_magnitude{octave,interval-1}(r,c)=sqrt(dx^2+dy^2);
                 
                 %%Store the orientation
                 if(dy>0 & dx>0)
                 image_orientation{octave,interval-1}(r,c)=double(atan(dy/dx));
                 else if(dy<0 & dx<0)
                         image_orientation{octave,interval-1}(r,c)=double(atan(dy/dx))+pi;
                     else if(dy>0 &dx<0)
                             image_orientation{octave,interval-1}(r,c)=double(atan(dy/dx))+pi;
                         else
                             image_orientation{octave,interval-1}(r,c)=double(atan(dy/dx));
                         end
                         
                     end
                 end
                 

             end
         end
         
         
         
     end
 end    
 
 %%
 %display('Computing the Orientation Histogram');
 hist_orient=zeros(1,36);%no of the bins are 36
 %Keypoint storage cell
 [krows kcols]=size(image_cell{4,1});
 keypoints=cell(krows*4,kcols*4);
 keypoints_final=zeros(number_keypoint+ceil(0.15*number_keypoint),5);
 nos=0;
 
 
 
 for octave=1:4
     scale=2^(octave-1);
     [nrows ncols]=size(image_cell{octave,1});
      for interval=2:3
         abs_sigma=sig(octave,interval);
          %%weight array
         image_weight=zeros(nrows,ncols);
         %%applying the gaussian filter on the magnitude 
         g=fspecial('gaussian',ceil(4*abs_sigma*1.5),abs_sigma*1.5);
         image_weight=imfilter(image_magnitude{octave,interval-1},g,'symmetric','conv');
         image_mask=zeros(nrows,ncols);
           
        
         for r=9:nrows-9
             
             for c=9:ncols-9
                     if(image_extrema{octave,interval-1}(r,c)==255)%if we are at the keypoint
                         hist_orient=zeros(1,36);
                         for x=-8:1:8
                             for y=-8:1:8
                                
                                     sample_orient=image_orientation{octave,interval-1}(r+x,c+y);  
                                     %sample_orient=sample_orient+pi;
                                     sample_orient_degrees=sample_orient*(180/pi);
                                      if(sample_orient_degrees<=0)
                                         sample_orient_degrees=360+sample_orient_degrees;
                                     end

                                     hist_orient(ceil( (sample_orient_degrees)/10))=hist_orient(ceil( (sample_orient_degrees)/10))+image_weight(r+x,c+y);
                                     image_mask(r+x,c+y)=255;
                             end
                         end
                         
                         
                         %%Computing the peaks of the histogram
                         %Check for the maximum
                         max_peak=hist_orient(1);
                         max_peak_index=1;
                         for k=1:36
                            if(max_peak<hist_orient(k))
                               max_peak=hist_orient(k);
                               max_peak_index=k;
                            end
                         end
                         
                         count=0;
                         for k=1:36
                               if(hist_orient(k)>0.8*max_peak)
                                   count=count+1;
                               end
                         end
                         
                         key=zeros(count);
                         count=0;
                         %Magnitudes and orientations at the current
                         %keypoint                         
                         %Better accuracy
                         for k=1:36
                             if(hist_orient(k)>0.8*max_peak)
                                 nos=nos+1;
                                 count=count+1;
                                 x1=k-1;
                                 x2=k;
                                 x3=k+1;
                                 y2=hist_orient(k);
                                 if(k==1)%extreme left
                                     y1=hist_orient(36);
                                     y3=hist_orient(2);
                                 
                                 elseif(k==36)%extreme right
                                    y1=hist_orient(35);
                                    y3=hist_orient(1);
                                    
                                 else
                                     y1=hist_orient(k-1);
                                     y3=hist_orient(k+1);
                                 end 
                                 
                                 Y=[y1;y2;y3];
                                 X=zeros(3,3);
                                 X(1,1)=x1^2;X(2,1)=x2^2;X(3,1)=x3^2;
                                 X(1,2)=x1;X(2,2)=x2;X(3,2)=x3;
                                 X(1,3)=1;X(2,3)=1;X(3,3)=1;
                                 X_inver=inv(X);
                                 b_mat=X_inver*Y;
                                 
                                 x0=double(-b_mat(2)/(2*b_mat(1)));
                                 
                                 %anomalous situaton
                                 if(abs(x0)>72)
                                     x0=x2;
                                 end
                                 
                                 while (x0<0)
                                     x0=x0+36;
                                 end
                                 
                                 while (x0>=36)
                                     x0=x0-36;
                                 end

								%Normalize it
                                x0_n=double(x0*(2*pi/36));
                                
                                if(x0_n>=0 && x0_n<2*pi)
                                   x0_n=x0_n-pi; 
                                end
                                key(count,1)=hist_orient(k);%save mag
                                key(count,2)=x0_n;%save orientation
                                key(count,3)=octave*2+interval-1;%save the scale
                                %save the magnitude and orientation of the
                                %keypoint
                                keypoints_final(nos,1)=ceil(r*(scale/2));
                                keypoints_final(nos,2)=ceil(c*(scale/2));
                                keypoints_final(nos,3)=hist_orient(k);
                                keypoints_final(nos,4)=x0_n;
                                keypoints_final(nos,5)=octave*2+interval-1;
                             end
                         end
                         xi=ceil(r*(scale/2));
                         yi=ceil(c*(scale/2));
                         keypoints{xi,yi}=key;
                       
                         
                         
                         
                     end
                     
             end
         end
         
         
      end
      
      
 end
keypoints_finals{start}=(keypoints_final);
files{start}= (Jpegfile(start).name);
 
 
%figure,imshow(image);
%hold on;
%for i=1:nos
    %plot(keypoints_final(i,2),keypoints_final(i,1),'.');
%end
%hold off;


end 
 save('model','keypoints_finals','files')
 
 
 
 
 
 
 
 
 
