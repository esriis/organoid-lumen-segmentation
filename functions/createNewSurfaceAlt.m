function createNewSurfaceAlt(handles)

dx = handles.dx;
dy = handles.dy;
dz = handles.dz;

X = [];
Y = [];
Z = [];
for i = 1:length(handles.smooth_perim)
    X = [X;handles.smooth_perim{i}(:,1)];
    Y = [Y;handles.smooth_perim{i}(:,2)];
    Z = [Z;(handles.slice_start:handles.slice_end)'];
end

for j = 1:length(handles.smooth_extra)
    extra = handles.smooth_extra{j};
    for i = 1:length(extra.perim)
        X = [X;extra.perim{i}(:,1)];
        Y = [Y;extra.perim{i}(:,2)];
        Z = [Z;(extra.slice(1):extra.slice(2))'];
    end
end


% isovalue = 50;

figure
colormap('parula')
% Ds = smooth3(DD,'box',[1,1,1]);


% Cs = ndgrid(linspace(0,1,size(Ds,1)),ones(1,size(Ds,2)),ones(1,size(Ds,3)));
% Cs = max(0,(Cs - min(Cs(Cs>0))));
% Cs = Cs./max(Cs);
% Cs = 1/2 - cos(Cs*pi)/2;
% Cs = 1/2 - cos(Cs*pi)/2;

surfaceStruct = isosurface(Ds,isovalue,Cs);
v = surfaceStruct.vertices;
f = surfaceStruct.faces;
cdata = surfaceStruct.facevertexcdata;

hiso = patch('Faces',f,'Vertices',v,'FaceVertexCData',cdata,...
   'FaceColor','flat',...
   'EdgeColor','none');
   isonormals(Ds,hiso)
   colorbar
   
   
   
   
hcap = patch(isocaps(Ds,isovalue),...
'FaceColor','interp',...
'EdgeColor','none');

view(35,30) 
axis tight 
daspect([1/dx,1/dy,K/dz])

lightangle(45,30);
lighting gouraud
material dull
hcap.AmbientStrength = 0.6;
hiso.SpecularColorReflectance = 0;
hiso.SpecularExponent = 50;

end