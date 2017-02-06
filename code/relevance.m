function  relevance( res,path,res1)
count=zeros(1,1);
z=length(res);
final=cell(1,z*5);

number=0;
for j=1:length(res)
    refined_img2=cell(1,5);
    refined_img2=search_images_SIFT1(res{j})
    for k=1:5
        number=number+1;
        final{z*(k-1)+j}=refined_img2{k};
        %count(number)=res1(j)+k;
        
    end    

end
final
%[count1 ind]=sort(count);
%final1=final(ind);
%final1
refined_img3=cell(1,1);
%a=final1{1};
next=1;
counter=1;
fuk=0;
q=1;
while(q<9)
    false=0;
    if (q==1)
        refined_img3{q}=final{next};
    else if(next~=length(final))
    a=final{next};    
     while(strcmp(final{next+1},a))
        next=next+1;
        if(next~=length(final))
            fuk=1;break;
        end
     end
     if(fuk==1)break;end
       a=final{next+1};
       next=next+1;
       for x=1:counter
        if(strcmp(refined_img3{x},final{next}))
         % if (next~=length(count)) next=next+1;end 
          false=1;q=q-1;
          break;
        end
       end
       if (false==0)
           refined_img3{counter+1}=final{next};
           counter=counter+1;
       end
        else break;
        end
    end
    refined_img3
q=q+1;
end
%refined_img3
figure(4)

%a=a-1;
im=imread(path);
subplot(3,3,1);imshow(im);title('query image');
%display(a);
%display(refined_img);
i=1;
for j=1:length(refined_img3)
    i=i+1;
    display(refined_img3{j});
    im1=imread(refined_img3{j});
    subplot(3,3,i);imshow(im1);title(refined_img3{j});
end
end
