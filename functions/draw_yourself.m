function handles = draw_yourself(hObject, eventdata, handles)
    slice_index = get(handles.slider,'Value');
    i = slice_index-handles.slice_start+2;
    
    handles.bw_past(:,:,i) = handles.bw5(:,:,i);
    hfh = imfreehand(handles.image_axes,'Closed',true); 
    % Starts freehand drawing for the current figure. Finish by pressing enter.
    bw_tmp = hfh.createMask();
    
    XY = hfh.getPosition;
    XY = XY(:,2:-1:1); % Interchanging x and y coordinates
    if size(XY,1)<=1
        return
    end
    
    se = strel('disk',5);
    handles.bw5(:,:,i) = imopen(bw_tmp,se);
    [a,b] = find(handles.bw5(:,:,i),1);
    [XY] = bwtraceboundary(handles.bw5(:,:,i),[a,b],'E');
    delete(hfh);
    
    X = XY(:,1);
    Y = XY(:,2);
    X2 = smooth(X,handles.smoothing_param);
    Y2 = smooth(Y,handles.smoothing_param);

    handles.smooth_perim{i} = [X2, Y2];

    set(handles.undo_button,'Enable','on')
    set(handles.undo_button,'String','Undo')
    handles = compute_curves(hObject,eventdata,handles,i,5,handles.smoothing_param);
    handles.undo_state(i) = 3;
    guidata(hObject,handles)
end