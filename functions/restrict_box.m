function handles = restrict_box(hObject, eventdata, handles)

    slice_index = get(handles.slider,'Value');
    i = slice_index-handles.slice_start+2;
    handles.bw_past(:,:,i) = handles.bw5(:,:,i);
    handles.I_denoise_past(:,:,i) = handles.I_denoise(:,:,i);
    
    rect = round(getrect(handles.image_axes));
    if ~length(rect)==4
        return
    end
    
    x1 = max(1,rect(1));
    x2 = min(size(handles.I_denoise,2),rect(1) + rect(3));
    y1 = max(1,rect(2));
    y2 = min(size(handles.I_denoise,1),rect(2) + rect(4));
    
    I_tmp = zeros(size(handles.I_denoise,1),size(handles.I_denoise,2));
    I_tmp(y1:y2,x1:x2) = 1;
    
    handles.I_denoise(:,:,i) = handles.I_denoise(:,:,i).*I_tmp - ~I_tmp;
 
    set(handles.undo_button,'Enable','on')
    set(handles.undo_button,'String','Undo')
    handles.undo_state(i) = 5;
    handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
    guidata(hObject,handles)
end