function handles = add_separate_region(hObject, eventdata, handles)
    slice_index = get(handles.slider,'Value');
    i = slice_index-handles.slice_start+2;
    
    handles.bw_past(:,:,i) = handles.bw5(:,:,i);
    hfh = imfreehand(handles.image_axes,'Closed',true); 
    % Starts freehand drawing for the current figure. Finish by pressing enter.
    bw_tmp = hfh.createMask();
    se = strel('disk',5);
    bw_tmp2 = imopen(bw_tmp,se);
    [a,b] = find(bw_tmp2,1);
    [XY] = bwtraceboundary(bw_tmp2,[a,b],'E');
    delete(hfh);
    
    X = XY(:,1);
    Y = XY(:,2);
    X2 = smooth(X,handles.smoothing_param);
    Y2 = smooth(Y,handles.smoothing_param);
    
    ind = size(handles.smooth_extra{i},1);
    handles.smooth_extra{i}{ind} = [X2, Y2];
    handles.smooth_extra{i} = [handles.smooth_extra{i}; cell(1)];

    set(handles.undo_button,'Enable','on')
    set(handles.undo_button,'String','Undo')
    handles.undo_state(i) = 3;
    guidata(hObject,handles)
end