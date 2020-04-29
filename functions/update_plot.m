function handles = update_plot(hObject, eventdata, handles)
    
    slice_index = get(handles.slider,'Value');
    i = slice_index + 1;
    
    v = get(handles.image_plot_list,'Value');
    overlay_flag = get(handles.overlay_tick,'Value');

    if v==2
        handles.image_plot = handles.I;
        ratio = handles.ratio_I;
        image_start = 1;
    elseif i < handles.slice_start || i > handles.slice_end
        ratio = handles.ratio_I_box;
        handles.image_plot = handles.I_box_full;
        image_start = 1;
        condition_full = true;
    else
        image_start = handles.slice_start;
        ratio = handles.ratio_I_box;
        if v==3
            handles.image_plot = handles.I_box;
        elseif v==4
            handles.image_plot = handles.I_denoise;
        elseif v==5
            handles.image_plot = handles.bw;
        elseif v==6
            handles.image_plot = handles.bw2;
        elseif v==7
            handles.image_plot = handles.bw3;
        elseif v==8
            handles.image_plot = handles.bw4;
        elseif v==9
            handles.image_plot = handles.bw5;
        elseif v==10
            handles.image_plot = handles.bw6;
        end
        condition_full = false;
    end
    
    j = i - image_start + 1;
    imagesc(handles.image_plot(:,:,j),'Parent',handles.image_axes)
    pbaspect(handles.image_axes,[1 ratio 1])
    title(handles.image_axes,['Slice ' num2str(slice_index)],'fontsize',15)
    
    if ~isempty(handles.rect) && v==2
        hold on
        rectangle('Position',handles.rect,'EdgeColor','r','LineWidth',1.4,'Parent',handles.image_axes);
        hold off
        set(handles.rect_flag,'Value',1)
    end
    

    if overlay_flag && v>2
        hold on
        if ~condition_full % ensure smooth_perim{i} is initialised
            j = i - handles.slice_start + 1;
            if ~isempty(handles.smooth_perim{j})
                plot(handles.image_axes,handles.smooth_perim{j}(:,2),...
                    handles.smooth_perim{j}(:,1),'Color','r','LineWidth',1)
            end
        end
        
        colors = {[255 165 240]/255,[255, 148, 0]/255,'g',[0.2 0 0]}; % list of colours
        for k=1:length(handles.smooth_extra)
            if i >= handles.smooth_extra{k}.slice(1) && i <= handles.smooth_extra{k}.slice(2)
                %~isempty(handles.smooth_extra{k}.perim{i})
                extra = handles.smooth_extra{k};
                j = i - extra.slice(1) + 1;
                perim = extra.perim{j};
                plot(handles.image_axes,perim(:,2),perim(:,1),'Color',...
                    colors{mod(k-1,length(colors))+1},'LineWidth',1)
            end
        end
        hold off
    end
    guidata(hObject,handles)
end