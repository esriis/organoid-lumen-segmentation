function [curveInt1,curveInt2] = curveAlignment(curve1, curve2,cLen)

    % Interpolate to cLen;

    s1 = size(curve1,1);
    s2 = size(curve2,1);
    coords = linspace(1+1e-5,s1-1e-5,cLen)';

    % Make sure coords are within index limits for curve1
    coords1 = max(min(ceil(coords),size(curve1,1)),1);
    coords2 = max(min(ceil(coords-1),size(curve1,1)),1);
    curveInt1 = [((coords-coords2).*curve1(coords1,1)...
        + (coords1-coords).*curve1(coords2,1)),...
        ((coords-coords2).*curve1(coords1,2)...
        + (coords1-coords).*curve1(coords2,2))];

    coords = linspace(1+1e-5,s2-1e-5,cLen)';
    % Make sure coords are within index limits for curve2
    coords1 = max(min(ceil(coords),size(curve2,1)),1);
    coords2 = max(min(ceil(coords-1),size(curve2,1)),1);

    curveInt2 = [((coords-coords2).*curve2(coords1,1)...
        + (coords1-coords).*curve2(coords2,1)),...
        ((coords-coords2).*curve2(coords1,2)...
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
end