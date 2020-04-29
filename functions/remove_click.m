function handles = remove_click(hObject, eventdata, handles)

    slice_index = get(handles.slider,'Value');
    i = slice_index-handles.slice_start+2;
    handles.bw_past(:,:,i) = handles.bw5(:,:,i);
    
    [y,x] = ginput(1);
    y = round(y);
    x = round(x);
    
    if handles.bw5(x,y,i) == 1
        handles.I_denoise(:,:,i) = handles.I_denoise(:,:,i).*(1-handles.bw5(:,:,i));
    end
 
    set(handles.undo_button,'Enable','on')
    set(handles.undo_button,'String','Undo')
    handles.undo_state(i) = 4;
    handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
    guidata(hObject,handles)
end