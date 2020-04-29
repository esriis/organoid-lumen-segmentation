function handles = add_region(hObject, eventdata, handles)
% This adds drawn region onto preexisting region
    slice_index = get(handles.slider,'Value');
    i = slice_index-handles.slice_start+2;
    
    handles.bw_past(:,:,i) = handles.bw5(:,:,i);
    % Starts freehand drawing for the current figure. Finish by pressing enter.
    hfh = imfreehand(handles.image_axes,'Closed',false); 
    XY = hfh.getPosition;
    XY = XY(:,2:-1:1); % Interchanging x and y coordinates
    if size(XY,1)<=1
        return
    end
    
    XY_ext = zeros(0,2);
    for j=1:size(XY,1)-1
        dist = ceil(sqrt((XY(j,1)-XY(j+1,1))^2 + (XY(j,2)-XY(j+1,2))^2));
        XY_1 = linspace(XY(j,1),XY(j+1,1),dist+1);
        XY_2 = linspace(XY(j,2),XY(j+1,2),dist+1);
        XY_ext = [XY_ext; XY(j,:); [XY_1',XY_2']];
    end
    XY_ind = round(XY_ext);
    XY_ind(:,1) = max(min(XY_ind(:,1),size(handles.I_box,1)),1);
    XY_ind(:,2) = max(min(XY_ind(:,2),size(handles.I_box,2)),1);
    
    delete(hfh);

    % Check that both tips are within the region
    if handles.bw5(XY_ind(1,1),XY_ind(1,2),i) == 0 || ...
            handles.bw5(XY_ind(end,1),XY_ind(end,2),i) == 0
        handles = update_plot(hObject, eventdata, handles);
        warndlg('Both ends of drawing must lie within region.','non-modal')
        return
    end
    
    bw5_tmp = handles.bw5(:,:,i);
    for j=1:size(XY_ind,1)
        bw5_tmp(XY_ind(j,1),XY_ind(j,2)) = 1;
        bw5_tmp(max(1,XY_ind(j,1)-1),XY_ind(j,2)) = 1;
    end
    bw5_tmp = imfill(bw5_tmp,'holes');
    handles.bw5(:,:,i) = bw5_tmp;
    
    set(handles.undo_button,'Enable','on')
    set(handles.undo_button,'String','Undo')
    handles.undo_state(i) = 1;
    handles = compute_curves(hObject,eventdata,handles,i,5,handles.smoothing_param);
    handles = update_plot(hObject, eventdata, handles);
    guidata(hObject,handles)
end