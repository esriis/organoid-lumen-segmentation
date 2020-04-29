function handles = create_spreadsheet(hObject, eventdata, handles)

dx = handles.dx;
dy = handles.dy;
dz = handles.dz;

%%

plotFlag = false;
handles = create_surface(hObject, eventdata, handles,plotFlag);

handles = compute_perim_vectors(hObject, eventdata, handles);



%% Store info

filename = 'data';

[file,path,indx] = uiputfile([filename '.csv']);

if indx
    fullname = [path file];
    dlmwrite(fullname,[dx,dy,dz])
    dlmwrite(fullname,handles.surfaceArea,'-append')
    dlmwrite(fullname,handles.slice_start_full-1:handles.slice_end_full-1,'-append')
    dlmwrite(fullname,[zeros(1,handles.slice_start-handles.slice_start_full),...
        handles.perim,zeros(1,handles.slice_end_full - handles.slice_end)],'-append')
    for i=1:length(handles.smooth_extra)
        dlmwrite(fullname,[zeros(1,handles.smooth_extra{i}.slice(1)-...
            handles.slice_start_full),handles.smooth_extra{i}.perim_vector,...
            zeros(1,handles.slice_end_full - handles.smooth_extra{i}.slice(2))],'-append')
    % dlmwrite(filename_table,[],'-append','roffset',1)
    end
end



%%

guidata(hObject,handles)
