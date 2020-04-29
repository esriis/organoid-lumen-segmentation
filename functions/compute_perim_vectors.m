function handles = compute_perim_vectors(hObject, eventdata, handles)

dx = handles.dx;
dy = handles.dy;

%% Main region

num_slice = handles.slice_num;

perim_vector = zeros(1,num_slice);

for i=1:num_slice
    curve = handles.smooth_perim{i};
    perim_vector(i) = sum(sqrt(dx^2*(curve(2:end,2)-curve(1:end-1,2)).^2+...
        dy^2*(curve(2:end,1)-curve(1:end-1,1)).^2));
end
handles.perim = perim_vector;


%% Extra regions

num_regions = length(handles.smooth_extra);

for j=1:num_regions
    extra = handles.smooth_extra{j};
    num_slice = extra.slice_num;
    perim_vector = zeros(1,num_slice);
    for i=1:num_slice
        curve = handles.smooth_extra{j}.perim{i};
            perim_vector(i) = sum(sqrt(dx^2*(curve(2:end,2)-curve(1:end-1,2)).^2+...
                dy^2*(curve(2:end,1)-curve(1:end-1,1)).^2));
    end
    handles.smooth_extra{j}.perim_vector = perim_vector;
end
