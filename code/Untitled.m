I1=imread('w1.jpg');
%I2=im2double(imread('TestImages/lena2.png'));
%image_s=size(I1);
%nr=image_s(1);
%nc=image_s(2);
% Get the Key Points
Options.upright=true;
Options.tresh=0.0001;
Ipts1=OpenSurf(I1,Options);
D1 = reshape([Ipts1.descriptor],64,[]);
source=load('model');
nsize=length(source.files);
%display(nsize);
%t=source.ipts_db.descriptor;
%display(t);
%x=cell(1,length(source.ipts_db));
for i=1:nsize
    display(source.files{i});
    %display(i);
    I2=imread(source.files{i});
    nr1=source.im_size{i}(1);
    nc1=source.im_size{i}(2);
    I1=imresize(I1,[nr1 nc1]);
    D2 = reshape([source.ipts_db{i}.descriptor],64,[]);
    err=zeros(1,length(Ipts1));
    cor1=1:length(Ipts1);
    cor2=zeros(1,length(Ipts1));
    for j=1:length(Ipts1)
        %display(length(source.ipts_db{i}));
        distance=sum((D2-repmat(D1(:,j),[1 length(source.ipts_db{i})])).^2,1);
        [err(j),cor2(j)]=min(distance);
    end
    [err, ind]=sort(err);
    cor1=cor1(ind);
    cor2=cor2(ind);

% Make vectors with the coordinates of the best matches
    Pos1=[[Ipts1(cor1).y]',[Ipts1(cor1).x]'];
    Pos2=[[ipts_db{i}(cor2).y]',[ipts_db{i}(cor2).x]'];
    Pos1=Pos1(1:30,:);
    Pos2=Pos2(1:30,:);
    %I = zeros([size(I1,1) size(I1,2)*2 size(I1,3)]);
   % I(:,1:size(I1,2),:)=I1; I(:,size(I1,2)+1:size(I1,2)+size(I2,2),:)=I2;

  %  figure, imshow(I);hold on;
%plot([Pos1(:,2) Pos2(:,2)+size(I1,2)]',[Pos1(:,1) Pos2(:,1)]','-');
%plot([Pos1(:,2) Pos2(:,2)+size(I1,2)]',[Pos1(:,1) Pos2(:,1)]','o');
%hold off;
Pos1(:,3)=1; Pos2(:,3)=1;
    M=Pos1'/Pos2';
    
    display(det(M));
    
    %display(t);
    if(det(M) > 0.15)
        display('Image is matched');
    else
        display('Image is NOT matched');
    end
end
