function createNewSurface(handles)

dx = handles.dx;
dy = handles.dy;
dz = handles.dz;

DDtmp = zeros(size(handles.I_box,1),size(handles.I_box,2),handles.slice_num_full);

% first add main region
DDtmp(:,:,(handles.slice_start:handles.slice_end)-handles.slice_start_full+1) = handles.bw5;

% then add other regions
for j = 1:length(handles.smooth_extra)
    extra = handles.smooth_extra{j};
    DDtmp(:,:,(extra.slice(1):extra.slice(2))-handles.slice_start_full+1) =...
        DDtmp(:,:,(extra.slice(1):extra.slice(2))-handles.slice_start_full+1)+extra.binary;
end

DDtmp2 = zeros(size(DDtmp)+[0,0,4]);
DDtmp2(:,:,3:end-2) = DDtmp;

DDtmp2 = DDtmp2*100;

K = 1;

DD = zeros(size(DDtmp2,1), size(DDtmp2,2), K*size(DDtmp2,3));

for i=1:size(DDtmp2,3)
    for j=1:K
        DD(:,:,K*(i-1)+j) = DDtmp2(:,:,i);
    end
end

isovalue = 50;

figure
colormap('parula')
Ds = smooth3(DD,'box',[1,1,1]);


Cs = ndgrid(linspace(0,1,size(Ds,1)),ones(1,size(Ds,2)),ones(1,size(Ds,3)));
Cs = max(0,(Cs - min(Cs(Cs>0))));
Cs = Cs./max(Cs);
Cs = 1/2 - cos(Cs*pi)/2;
Cs = 1/2 - cos(Cs*pi)/2;



% for i=1:size(Ds,3)
%     Es = Ds(:,:,i);
% %     tot_mass = sum(Es(:));
% %     [ii,jj] = ndgrid(1:size(Es,1),1:size(Es,2));
% %     xc = sum(ii(:).*Es(:))/tot_mass;
% %     yc = sum(jj(:).*Es(:))/tot_mass;
%     if sum(abs(Es(:))) ~= 0
%         Ctmp = linspace(0,1,size(Es,1))'*ones(1,size(Es,2));
%         Ctmp = Ctmp.*(Es~=0);
%         Ctmp = max(0,(Ctmp - min(Ctmp(Ctmp>0))));
%         Ctmp = Ctmp./max(Ctmp(:));
%         Cs(:,:,i) = Ctmp;
%     end
% end



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