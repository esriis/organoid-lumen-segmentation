function [handles, surface_area] = compute_surface(hObject, eventdata, handles) %, curve1, curve2, i1)

dx = handles.dx;
dy = handles.dy;
dz = handles.dz;

surface_area = 0;

num_region = length(handles.smooth_extra);
num_slice = size(handles.smooth_perim,1);



%%

for i=1:num_slice-1
    % First add areas of the P = 1 bits
    if handles.regStruct.P(i,1)
        c1 = handles.smooth_perim_align{i}(:,1);
        c2 = handles.smooth_perim_align{i}(:,2);
        surface_area = surface_area + compute_surface_element(hObject,...
            eventdata, handles, c1, c2);
    end
    
    for j=1:num_region
        if handles.regStruct.P(i,j+1)
            c1 = handles.smooth_extra{j}.perim_align{i}(:,1);
            c2 = handles.smooth_extra{j}.perim_align{i}(:,2);
%             perim_vector(i) = sum(sqrt(dx^2*(curve1(2:end,2)-curve1(1:end-1,2)).^2+...
%                 dy^2*(curve1(2:end,1)-curve1(1:end-1,1)).^2));
            surface_area = surface_area + compute_surface_element(hObject,...
            eventdata, handles, c1, c2);
        end
    end
    
end


%% Add bits on the ends

curve2 = handles.smooth_perim{1};
[handles, area_tmp] = compute_surface_cap_element(hObject, eventdata, handles, curve2, 1,0);
surface_area = surface_area + area_tmp;

% End
curve2 = handles.smooth_perim{end};
[handles, area_tmp] = create_surface_cap(hObject, eventdata, handles, ...
    curve2, num_slice,num_slice+1);
surface_area = surface_area + area_tmp;

for i=1:length(handles.smooth_extra)
    if handles.regStruct.B(i)
        ind = handles.smooth_extra{i}.slice(1);
        curve2 = handles.smooth_extra{i}.perim{ind};
        [handles, area_tmp] = create_surface_cap(hObject, eventdata, handles, ...
            curve2, ind,ind-1);
        surface_area = surface_area + area_tmp;
    end
    
    if handles.regStruct.E(i)
        ind = handles.smooth_extra{i}.slice(2);
        curve2 = handles.smooth_extra{i}.perim{ind};
        [handles, area_tmp] = create_surface_cap(hObject, eventdata, handles, ...
            curve2, ind,ind+1);
        surface_area = surface_area + area_tmp;
    end
end

hold off

handles.surfaceArea = surface_area;
