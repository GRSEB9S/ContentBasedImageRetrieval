%%
function[x,y,sort_fin] =knne(train,test_temp)
%KNN

kn=6;

sdist=zeros(1,length(train));

    for k=1:length(train)
       sdist(k)=sqrt(sum((train(k,3:5)-test_temp(3:5)).*(train(k,3:5)-test_temp(3:5)))); 
    end
    
    sdist=sdist';
    sort_array=[sdist train(:,1) train(:,2)];
    sort_array=sortrows(sort_array);
    k_near=sort_array(1:kn,2:3);
    
    new_d=zeros(1,kn);
    for i=1:kn
    new_d(i)=sqrt(sum((test_temp(1:2)-k_near(i,:)).*(test_temp(1:2)-k_near(i,:))));
    end
    
    new_d=new_d';
    arey=[new_d k_near];
    sort_fin=sortrows(arey);
    x=sort_fin(1,2);
    y=sort_fin(1,3);
   
    
    
    
                
    



 