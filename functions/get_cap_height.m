function height = get_cap_height(hObject, eventdata,...
    handles, curve1, curve2)

dx = handles.dx;
dy = handles.dy;

if isempty(curve1)
    height = 0.8;
else
    
    cLen = 100; % What's appropriate length?

    % Interpolate to cLen;

    s1 = size(curve1,1);
    s2 = size(curve2,1);
    coords = linspace(1+1e-5,s1-1e-5,cLen)';
    curveInt1 = [dx*((coords-ceil(coords-1)).*curve1(ceil(coords),1)...
        + (ceil(coords)-coords).*curve1(ceil(coords-1),1)),...
        dy*((coords-ceil(coords-1)).*curve1(ceil(coords),2)...
        + (ceil(coords)-coords).*curve1(ceil(coords-1),2))];

    coords = linspace(1+1e-5,s2-1e-5,cLen)';
    curveInt2 = [dx*((coords-ceil(coords-1)).*curve2(ceil(coords),1)...
        + (ceil(coords)-coords).*curve2(ceil(coords-1),1)),...
        dy*((coords-ceil(coords-1)).*curve2(ceil(coords),2)...
        + (ceil(coords)-coords).*curve2(ceil(coords-1),2))];
    
    % compute centres
    cx1 = mean(curveInt1(:,1));
    cy1 = mean(curveInt1(:,2));
    cx2 = mean(curveInt2(:,1));
    cy2 = mean(curveInt2(:,2));
    

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
    
    ratio = mean(sqrt( (cx2-curveInt2(:,1)).^2 + (cy2 - curveInt2(:,2)).^2)...
        ./ sqrt( (cx1-curveInt1(:,1)).^2 + (cy1 - curveInt1(:,2)).^2) );
    height = min(1,ratio*0.75);
end

end