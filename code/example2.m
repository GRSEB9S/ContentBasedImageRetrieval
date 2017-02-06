% Example 2, Corresponding points
% Load images
  I1=imread('TestImages/testc1.png');
  I2=imread('TestImages/testc2.png');
% Get the Key Points
  Options.upright=true;
  Options.tresh=0.0001;
  Ipts1=OpenSurf(I1,Options);
