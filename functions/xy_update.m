function handles = xy_update(hObject, eventdata, handles,direction)

if strcmp(direction,'xy2rect')
    if ~isempty(get(handles.x1_value,'String')) && ~isempty(get(handles.x2_value,'String')) ...
            && ~isempty(get(handles.y1_value,'String')) && ~isempty(get(handles.y2_value,'String'))
        handles.rect(1) = str2num(get(handles.x1_value,'String'));
        handles.rect(2) = str2num(get(handles.y1_value,'String'));
        handles.rect(3) = str2num(get(handles.x2_value,'String')) - handles.rect(1);
        handles.rect(4) = str2num(get(handles.y2_value,'String')) - handles.rect(2);
        set(handles.rect_flag,'Value',1)
        set(handles.restrict_button,'Visible','on')
    else
        set(handles.restrict_button,'Visible','off')
        return
    end
elseif strcmp(direction,'rect2xy')
    if length(handles.rect)==4
        
        set(handles.x1_value,'String',num2str(handles.rect(1)));
        set(handles.y1_value,'String',num2str(handles.rect(2)));
        set(handles.x2_value,'String',num2str(handles.rect(1)+handles.rect(3)));
        set(handles.y2_value,'String',num2str(handles.rect(2)+handles.rect(4)));
    elseif isempty(handles.rect)
        set(handles.x1_value,'String','');
        set(handles.y1_value,'String','');
        set(handles.x2_value,'String','');
        set(handles.y2_value,'String','');
    end

handles = update_plot(hObject, eventdata, handles);
guidata(hObject,handles)

end