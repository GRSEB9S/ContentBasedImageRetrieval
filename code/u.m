%function checkbox_example()
close all; clc
M = zeros(5,2); % Matrix for checkbox values
for i = 1:10
    subplot(2,5,i)
    ax(i) = gca; %#ok<AGROW>
    set(ax(i),'units','pixels')
    pa = get(ax(i),'Position'); % Position of subplot axes
    subimage(randi(3,6,4),jet(3));
    set(ax(i),'XTickLabel',{},'YTickLabel',{},...
              'XTick',[],'YTick',[],'TickLength',[0 0])
    h(i) = uicontrol('Style','checkbox',...
                     'Position',[pa(1) pa(2)-5 pa(3) 20],...
                     'String',['Text' num2str(i)],...
                     'Callback', @box_value);
end
function box_value(hObj,event) %#ok<INUSD>
        % Called when boxes are used
        val = get(hObj,'Value');
        M(h==hObj) = val;
        disp(M')
end
end