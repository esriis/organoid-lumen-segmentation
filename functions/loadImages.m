function handles = loadImages(hObject, eventdata, handles)

image_path = uigetdir;
if ~image_path
    return
end
listing = dir(image_path);


count = length(listing)-2;

if count == 0
    errordlg(['Folder ' image_path ' is empty.'])
    return
end

handles.slice_start = 1;
handles.slice_start_full = handles.slice_start;
handles.slice_end = count;
handles.slice_end_full = handles.slice_end;
handles.slice_num = count;
handles.slice_num_full = handles.slice_num;
set(handles.slice_end_value,'String',num2str(0));
set(handles.slice_end_value,'String',num2str(handles.slice_end-1));

% Get image dimensions    
filename = [image_path, '/', listing(3).name];
[Nx, Ny, num_color_channels] = size(imread(filename));
handles.I = zeros(Nx,Ny,handles.slice_num);

% Load images
count = 1;
h = waitbar(0,'Loading images');
for i = 3:length(listing)
    waitbar(count/handles.slice_num,h)
    im_tmp = imread([image_path, '/', listing(i).name]);
    if num_color_channels == 3
        handles.I(:,:,count) = rgb2gray(im_tmp);
    elseif num_color_channels == 1
        handles.I(:,:,count) = im_tmp;
    end
    count = count+1;
end

handles.I = handles.I/max(handles.I(:));

set(handles.load_panel,'Visible','off')
position_tmp = get(handles.load_panel,'Position');
position = get(handles.coordinate_panel,'Position');
position(1) = position_tmp(1);
position(2) = position_tmp(2) + position_tmp(4) - position(4);
set(handles.coordinate_panel,'Position',position)
set(handles.coordinate_panel,'Visible','on')
set(handles.slider,'Min',handles.slice_start_full-1)
set(handles.slider,'Max',handles.slice_end_full-1)
set(handles.slider,'Value',handles.slice_start_full-1)
if handles.slice_num_full > 1
    set(handles.slider,'SliderStep',[1/(handles.slice_num_full-1) 1/(handles.slice_num_full-1)])
    set(handles.slider,'Visible','on')
end
set(handles.image_plot_list,'Value',2)
handles.ratio_I = size(handles.I,1)/size(handles.I,2);
handles = update_plot(hObject, eventdata, handles);

close(h)
guidata(hObject,handles)

end
