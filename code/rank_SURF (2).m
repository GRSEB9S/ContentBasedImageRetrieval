function rank_SURF(res,path)
[res ind]=sort(res,'descend');
a=1;
source=load('model');
display(path);
%nsize=length(source.ipts_db);
%a1=source.files{start};
refined_img=cell(1,11);
for i=1:length(res)
    if(res(i) > 0.70)
        a=a+1;
        refined_img{i}=source.files{ind(i)};
    end
end
S.fh = figure('units','pixels',...
              'position',[250 200 800 400],...
              'menubar','none',...
              'name','Verify Password.',...
              'resize','off',...
              'numbertitle','off',...
              'name','Search Images');
a=a-1;
im=imread(path);
subplot(ceil(sqrt(a)),ceil(sqrt(a)),1);imshow(im);title('query image');
%display(a);
%display(refined_img);
i=1;
for j=1:a
    i=i+1;
    display(refined_img{j});
    im=imread(refined_img{j});
    subplot(ceil(sqrt(a)),ceil(sqrt(a)),i);imshow(im);title(refined_img{j});
    %for j=1:9
    S.rd(j) = uicontrol('style','check',...
                         'unit','pix',...
                         'position',[70*(j-1) 40  70 20],...
                         'string',sprintf('%s',refined_img{j}),'Value',0);
end
S.refinedsearch_RF = uicontrol('style','push',...
                 'units','pix',...
                 'position',[0 10 40 40],...
                 'backgroundcolor','w',...
                 'HorizontalAlign','left',...
                 'string','RF',...
                 'fontsize',8,'fontweight','bold',...
                 'callback',{@ref_call_RF,S});
function [] = ref_call_RF(varargin)
% Callback for pushbutton.
%S = varargin{3};
%L = get(S.ls,'string');  % Get the editbox strin
values=zeros(1,a);
for k=1:a 
    values(k) = get(S.rd(k), 'Value');            
end
display(values);
end
end
