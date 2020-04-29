function handles = remove_current(hObject, eventdata, handles)
    slice_index = get(handles.slider,'Value');
    i = slice_index-handles.slice_start+2;
    handles.bw_past(:,:,i) = handles.bw5(:,:,i);
    handles.I_denoise_past(:,:,i) = handles.I_denoise(:,:,i);
    handles.I_denoise(:,:,i) = handles.I_denoise(:,:,i).*(1-handles.bw5(:,:,i));
    handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
    
end