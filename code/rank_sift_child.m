function refined_img = rank_sift_child(res,path)
[res ind]=sort(res,'descend');

source=load('model');
display(path);
%nsize=length(source.ipts_db);
%a1=source.files{start};
refined_img=cell(1,1);
for i=1:5
     refined_img{i}=source.files{ind(i)};
end
end
