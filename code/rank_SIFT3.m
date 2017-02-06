function rank_SIFT3(Jpeg,res,I1)
[res ind]=sort(res,'descend');
a=1;
%source=load('model');
%display(path);
%nsize=length(source.ipts_db);
%a1=source.files{start};
refined_img1=cell(1,2);
for i=1:length(res)
    if(res(i) > 0.05)
        a=a+1;
        refined_img1{i}=Jpeg{ind(i)};
    end
end
figure(3)
x=ceil(sqrt(a));
%im=imread(path);
subplot(x,x,1);imshow(I1);title('query image');
%display(a);
%display(refined_img);
i=1;
for j=1:a-1
    i=i+1;
    display(refined_img1{j});
    im=imread(refined_img1{j});
    subplot(x,x,i);imshow(im);title(refined_img1{j});
end

