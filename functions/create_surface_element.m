function surface_area = create_surface_element(hObject, eventdata, handles,...
    curve1, curve2,i1,i2,plotFlag)

dx = handles.dx;
dy = handles.dy;
dz = handles.dz;

cLen = 100; % What's appropriate length?

% Interpolate to cLen;

s1 = size(curve1,1);
s2 = size(curve2,1);
coords = linspace(1+1e-5,s1-1e-5,cLen)';

% Make sure coords are within index limits for curve1
coords1 = max(min(ceil(coords),size(curve1,1)),1);
coords2 = max(min(ceil(coords-1),size(curve1,1)),1);
curveInt1 = [dx*((coords-coords2).*curve1(coords1,1)...
    + (coords1-coords).*curve1(coords2,1)),...
    dy*((coords-coords2).*curve1(coords1,2)...
    + (coords1-coords).*curve1(coords2,2))];

coords = linspace(1+1e-5,s2-1e-5,cLen)';
% Make sure coords are within index limits for curve2
coords1 = max(min(ceil(coords),size(curve2,1)),1);
coords2 = max(min(ceil(coords-1),size(curve2,1)),1);

curveInt2 = [dx*((coords-coords2).*curve2(coords1,1)...
    + (coords1-coords).*curve2(coords2,1)),...
    dy*((coords-coords2).*curve2(coords1,2)...
    + (coords1-coords).*curve2(coords2,2))];

% Compute distance matrix

distMat = repmat(curveInt2,[1,1,2*cLen]);
curveFlip = flip(curveInt1,1);
for j=1:cLen
    distMat(:,:,j) = distMat(:,:,j) - circshift(curveInt1,j-1);
    distMat(:,:,j+cLen) = distMat(:,:,j+cLen) - circshift(curveFlip,j-1);
end
distMat = squeeze(sqrt(distMat(:,1,:).^2+distMat(:,2,:).^2));
distVec = squeeze(sum(distMat,1));
[~,J] = min(distVec);
if J <= cLen
    curveInt1 = circshift(curveInt1,J-1);
else
    curveInt1 = circshift(curveFlip,J-1);
end




% Compute areas of triangles

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
