function rank_SURF(res,path)
[res ind]=sort(res,'descend');
a=1;
source=load('model');
display(path);
%nsize=length(source.ipts_db);
%a1=source.files{start};
refined_img=cell(1,1);
M=zeros(1,10)
for i=1:10
     refined_img{i}=source.files{ind(i)};
end
figure(3);
%a=a-1;
%im=imread(path);
%subplot(5,5,1);subimage(im);title('query image');
%display(a);
%display(refined_img);
i=0;
for j=1:10
    i=i+1;
    display(refined_img{j});
    im1=imread(refined_img{j});
    subplot(5,5,i);subimage(im1);hold on;
    ax(i)=gca;
    set(ax(i),'units','pixels')
    pa = get(ax(i),'Position'); % Position of subplot axes
    subimage(randi(3,6,4),jet(3));
    set(ax(i),'XTickLabel',{},'YTickLabel',{},...
              'XTick',[],'YTick',[],'TickLength',[0 0])
    h(i) = uicontrol('Style','checkbox',...
                     'Position',[pa(1) pa(2)-20 pa(3) 20],...
                     'String',[refined_img{j}],...
                     'Callback', @box_value);hold off;
    %subplot(5,5,i);imshow(im1);title(refined_img{j});
    %S.rd(j) = uicontrol('style','check',...
     %                    'unit','pix',...
      %                   'position',[70*(j-1) 40  70 20],...
       %                  'string',sprintf('%s',refined_img{j}),'Value',0);
end
%khel1(refined_img,im);
%khel(refined_img,im);
%shape1(refined_img,im);
%S.refinedsearch_RF = uicontrol('style','push',...
 %                'units','pix',...
  %               'position',[0 10 40 40],...
   %              'backgroundcolor','w',...
    %             'HorizontalAlign','left',...
     %            'string','RF',...
      %           'fontsize',8,'fontweight','bold',...
       %          'callback',{@ref_call_RF,S});
%function [] = ref_call_RF(varargin)
% Callback for pushbutton.
%S = varargin{3};
%L = get(S.ls,'string');  % Get the editbox strin
function box_value(hObj,event) %#ok<INUSD>
        % Called when boxes are used
        val = get(hObj,'Value');
        M(h==hObj) = val;
        disp(M)
end

end

%end

