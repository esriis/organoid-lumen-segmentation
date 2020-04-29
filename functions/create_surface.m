function [handles,surface_area] = create_surface(hObject, eventdata, handles,plotFlag)

if plotFlag
    figure
    hold on
end

surface_area = 0;

num_region = length(handles.smooth_extra);
num_slice = size(handles.I,3);


%% Make curves full length for easier indexing

smooth_perim = cell(num_slice,1);
smooth_perim(handles.slice_start:handles.slice_end) = handles.smooth_perim;
smooth_extra = cell(length(handles.smooth_extra),1);
for j=1:length(handles.smooth_extra)
    smooth_extra{j}.perim = cell(num_slice,1);
    extra = handles.smooth_extra{j};
    smooth_extra{j}.perim(extra.slice(1):extra.slice(2)) = extra.perim;
end


%% Connect consecutive slices



for i=1:num_slice-1
    % First add areas of the P = 1 bits
    if handles.regStruct.P(i,1)
        curve1 = smooth_perim{i};
        curve2 = smooth_perim{i+1};
        surface_area = surface_area + create_surface_element(hObject, eventdata,...
            handles, curve1, curve2,i,i+1,plotFlag);
    end
    
    for j=1:num_region
        if handles.regStruct.P(i,j+1)
            curve1 = smooth_extra{j}.perim{i};
            curve2 = smooth_extra{j}.perim{i+1};
            surface_area = surface_area + create_surface_element(hObject,eventdata,...
                handles, curve1, curve2,i,i+1,plotFlag);
        end
    end
    
end


%% Do mergers

mergers = handles.regStruct.mergers;

for i=1:length(mergers)
    ind1 = mergers{i}.ind;
    ind2 = ind1+1;
    handles = merger_function(hObject,eventdata,handles,mergers{i},ind1,ind2,plotFlag,'merger');
end

splits = handles.regStruct.splits;

for i=1:length(splits)
    ind2 = splits{i}.ind;
    ind1 = ind2+1;
    handles = merger_function(hObject,eventdata,handles,splits{i},ind1,ind2,plotFlag,'split');
end


%% Add bits on the ends

curve2 = smooth_perim{handles.slice_start};
curve1 = smooth_perim{handles.slice_start+1};
height = get_cap_height(hObject,eventdata,handles,curve1,curve2);

surface_area = surface_area + create_surface_cap(hObject, eventdata, handles,...
    curve2, handles.slice_start,handles.slice_start-height,plotFlag);

% End
curve2 = smooth_perim{handles.slice_end};
curve1 = smooth_perim{handles.slice_end-1};
height = get_cap_height(hObject,eventdata,handles,curve1,curve2);

surface_area = surface_area + create_surface_cap(hObject, eventdata, handles, ...
    curve2, handles.slice_end,handles.slice_end+height,plotFlag);

for i=1:length(smooth_extra)
    if handles.regStruct.B(i)
        ind = handles.smooth_extra{i}.slice(1);
        curve2 = smooth_extra{i}.perim{ind};
        if ind > 1
            curve1 = smooth_extra{i}.perim{ind-1};
        else
            curve1 = [];
        end
        height = get_cap_height(hObject,eventdata,handles,curve1,curve2);
        
        surface_area = surface_area + create_surface_cap(hObject, eventdata, handles, ...
            curve2, ind,ind-height,plotFlag);
    end
    
    if handles.regStruct.E(i)
        ind = handles.smooth_extra{i}.slice(2);
        curve2 = smooth_extra{i}.perim{ind};
        if ind < num_slice
            curve1 = smooth_extra{i}.perim{ind+1};
        else
            curve1 = [];
        end
        height = get_cap_height(hObject,eventdata,handles,curve1,curve2);
        
        surface_area = surface_area + create_surface_cap(hObject, eventdata, handles, ...
            curve2, ind,ind+height,plotFlag);
    end
end

if plotFlag
    hold off
end

handles.surfaceArea = surface_area;
