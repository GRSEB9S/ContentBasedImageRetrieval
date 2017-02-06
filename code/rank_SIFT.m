function rank_SIFT(res,path)
[res ind]=sort(res,'descend');
a=1;
source=load('model');
display(path);
%nsize=length(source.ipts_db);
%a1=source.files{start};
refined_img=cell(1,1);
for i=1:20
     refined_img{i}=source.files{ind(i)};
end
figure(2)
%a=a-1;
im=imread(path);
subplot(5,5,1);imshow(im);title('query image');
%display(a);
%display(refined_img);
i=1;
for j=1:20
    i=i+1;
    display(refined_img{j});
    im1=imread(refined_img{j});
    subplot(5,5,i);imshow(im1);title(refined_img{j});
end
%khel1(refined_img,im);
%khel(refined_img,im);
%shape1(refined_img,im);
end
