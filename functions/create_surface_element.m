function surface_area = create_surface_element(hObject, eventdata, handles,...
    curve1, curve2,i1,i2,plotFlag)

dx = handles.dx;
dy = handles.dy;
dz = handles.dz;

%% Align curves 

clen = 100;

[curveInt1, curveInt2] = curveAlignment(curve1, curve2,clen);

curveInt1(:,1) = dx*curveInt1(:,1);
curveInt1(:,2) = dy*curveInt1(:,2);

curveInt2(:,1) = dx*curveInt2(:,1);
curveInt2(:,2) = dy*curveInt2(:,2);

%% Compute areas of triangles

cInt1 = [curveInt1,dz*i1*ones(size(curveInt1,1),1)];
cInt2 = [curveInt2,dz*i2*ones(size(curveInt2,1),1)];

AVec1 = circshift(cInt1,-1) - cInt1;
BVec1 = cInt2 - cInt1;

AVec2 = circshift(cInt2,-1) - cInt2;
BVec2 = circshift(BVec1,-1);

area1 = sqrt(sum(cross(AVec1,BVec1).^2,2))/2;
area2 = sqrt(sum(cross(AVec2,BVec2).^2,2))/2;

surface_area = sum(area1 + area2);

if plotFlag
    X = [cInt1',cInt2'];
    Y = [circshift(cInt1,-1)', circshift(cInt2,-1)'];
    Z = [cInt2',circshift(cInt1,-1)'];

    XX = [X(1,:); Y(1,:); Z(1,:)];
    YY = [X(2,:); Y(2,:); Z(2,:)];
    ZZ = [X(3,:); Y(3,:); Z(3,:)];
    col = 1:round(size(XX,2)/4);
    C = [col,flip(col),col,flip(col)];
    fill3(XX,YY,ZZ,C,'LineWidth',0.000001,'EdgeAlpha',0.5)
end
