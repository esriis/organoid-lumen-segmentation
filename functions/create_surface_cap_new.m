function surface_area = create_surface_cap_new(hObject, eventdata,...
    handles, curve2, z1,z2,plotFlag)

dx = handles.dx;
dy = handles.dy;

surface_area = 0;

cx = dx*mean(curve2(:,1));
cy = dy*mean(curve2(:,2));
curve1 = (curve2-ones(size(curve2,1),1)*[cx/dx,cy/dy])/3 + ones(size(curve2,1),1)*[cx/dx,cy/dy];
surface_area = surface_area + create_surface_element(hObject, eventdata, handles,...
    curve1, curve2, z1 +(z2-z1)*0.8,z1,plotFlag);

curve2 = curve1;
curve1 = (curve2-ones(size(curve2,1),1)*[cx/dx,cy/dy])/4 + ones(size(curve2,1),1)*[cx/dx,cy/dy];
surface_area = surface_area + create_surface_element(hObject, eventdata, handles, curve1, ...
    curve2,z1 +(z2-z1)*0.98,z1 +(z2-z1)*0.8,plotFlag);

curve2 = curve1;
curve1 = (curve2-ones(size(curve2,1),1)*[cx/dx,cy/dy])/4 + ones(size(curve2,1),1)*[cx/dx,cy/dy];
surface_area = surface_area + create_surface_element(hObject, eventdata, handles,...
    curve1, curve2,z2,z1 +(z2-z1)*0.98,plotFlag);
end