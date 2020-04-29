function handles = remove_region(hObject, eventdata, handles)
% Remove region by drawing
    slice_index = get(handles.slider,'Value');
    i = slice_index-handles.slice_start+2;
    
    handles.bw_past(:,:,i) = handles.bw5(:,:,i);
    hfh = imfreehand(handles.image_axes,'Closed',false); % Starts freehand drawing 
    % for the current figure. Finish by pressing enter.
    XY = hfh.getPosition;
    XY = XY(:,2:-1:1);
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
    
    % Check that both tips are outside of the region
    if handles.bw5(XY_ind(1,1),XY_ind(1,2),i) == 1 || ...
            handles.bw5(XY_ind(end,1),XY_ind(end,2),i) == 1
        handles = update_plot(hObject, eventdata, handles);
        warndlg('Both ends of drawing must lie outside of region.','non-modal')
        return
    end

    bw5_tmp = handles.bw5(:,:,i);
    for j=1:size(XY_ind,1)
        bw5_tmp(XY_ind(j,1),XY_ind(j,2)) = 0;
        bw5_tmp(XY_ind(j,1)+1,XY_ind(j,2)) = 0;
    end
    
    CC = bwconncomp(bw5_tmp);
    [~,ind] = max(cellfun(@(x) size(x,1), CC.PixelIdxList));
    bw5_tmp = zeros(size(bw5_tmp));
    bw5_tmp(CC.PixelIdxList{ind}) = 1;
    handles.bw5(:,:,i) = bw5_tmp;
    
    set(handles.undo_button,'Enable','on')
    set(handles.undo_button,'String','Undo')
    handles.undo_state(i) = 1;
    handles = compute_curves(hObject,eventdata,handles,i,5,handles.smoothing_param);
    guidata(hObject,handles)
end