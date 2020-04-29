function handles = add_point(hObject, eventdata, handles)
    slice_index = get(handles.slider,'Value');
    i = slice_index-handles.slice_start+2;
    disk = max(1,round(handles.disk_param(i)*(size(handles.I_denoise,1)...
        +size(handles.I_denoise,2))/2));
    handles.bw_past(:,:,i) = handles.bw5(:,:,i);
    
    [y,x] = ginput(1);
    y = round(y);
    x = round(x);
    [vec_x, vec_y] = find(handles.bw5(:,:,i));
    dist_vec = max(abs(x-vec_x),abs(y-vec_y));
    dist_min = min(dist_vec);
    dist_min_x = dist_min;
    dist_min_y = dist_min;
    I_region = handles.I_denoise(max(x-dist_min_x,1):min(x+dist_min_x,...
        size(handles.I_denoise,1)),max(1,y-dist_min_y):...
        min(size(handles.I_denoise,2),y+dist_min_y),i);
    bw_tmp = I_region >= graythresh(I_region/max(I_region(:)))*max(I_region(:))*1;
%         *handles.threshold_param(i);
    bw2_tmp = imfill(bw_tmp,'holes');
    bw3_tmp = bwareaopen(bw2_tmp, round(0.01*sum(bw2_tmp(:))));
    bw_tmp_close = padarray(bw3_tmp,[disk disk],'both');
    bw_tmp_close = imclose(bw_tmp_close, strel('disk',disk));
    bw4_tmp = bw_tmp_close((disk+1):(end-disk),...
        (disk+1):(end-disk));
    bw4_tmp = imfill(bw4_tmp,'holes');
    bw5_tmp = bwareafilt(logical(bw4_tmp),1);
    bw5_tmp = bw5_tmp.*logical(bw3_tmp);
    bw_tmp_close = padarray(bw5_tmp,[disk disk],'both');
    bw_tmp_close = imclose(bw_tmp_close, strel('disk',disk));
    bw5_tmp = bw_tmp_close((disk+1):(end-disk),...
        (disk+1):(end-disk));
    bw5_tmp = imfill(bw5_tmp,'holes');
    bw5_tmp_full = zeros(size(handles.bw5,1),size(handles.bw5,2));
    bw5_tmp_full(max(x-dist_min_x,1):min(x+dist_min_x,...
        size(handles.I_denoise,1)),max(1,y-dist_min_y):...
        min(size(handles.I_denoise,2),y+dist_min_y)) = bw5_tmp;
    handles.bw5(:,:,i) = max(handles.bw5(:,:,i),bw5_tmp_full);
    bw_tmp_close = padarray(handles.bw5(:,:,i),[disk disk],'both');
    bw_tmp_close = imclose(bw_tmp_close, strel('disk',disk));
    handles.bw5(:,:,i) = bw_tmp_close((disk+1):(end-disk),...
        (disk+1):(end-disk));
    handles.bw5(:,:,i) = imfill(handles.bw5(:,:,i),'holes');
    
    set(handles.undo_button,'Enable','on')
    set(handles.undo_button,'String','Undo')
    handles.undo_state(i) = 1;
    handles = compute_curves(hObject,eventdata,handles,i,5,handles.smoothing_param);
    guidata(hObject,handles)
end