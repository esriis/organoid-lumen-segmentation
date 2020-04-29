function [bwParent,mergeCurve,handles] = compute_merger(hObject, eventdata, handles,...
    curve1, curve2, bwParent,bwInd,ratioGoal,pixParent,z1,z2,plotFlag)

% Compute centres to compare relative position
c2 = mean(curve2,1);
c1 = mean(curve1,1);
d12 = c2 - c1; % direction
d12 = d12/norm(d12);

% Want to parametrise line... and incrementally move it until the
% ratio is right.
mask = bwInd(:,:,1)*d12(1) + bwInd(:,:,2)*d12(2) - dot(c1,d12) < 0;

ratio = sum(sum(mask.*bwParent))/pixParent;
err = ratioGoal - ratio;
step = 2*sign(err); % If ratio is too low, move away.
errFlag = true;
stepNum = 0;
while errFlag
    stepNum = stepNum + 1;
    mask = bwInd(:,:,1)*d12(1) + bwInd(:,:,2)*d12(2) - dot(c1,d12) - stepNum*step < 0;
    ratio = sum(sum(mask.*bwParent))/pixParent;
    errPrev = err;
    err = ratioGoal - ratio;
    if abs(err) > abs(errPrev)
        errFlag = false;
    end
end
% Create new curve. Then do create surface code.
stepNum = stepNum - 1;
mask = bwInd(:,:,1)*d12(1) + bwInd(:,:,2)*d12(2) - dot(c1,d12) - stepNum*step < 0;
bwParent1 = bwParent.*mask;
bwParent = bwParent - bwParent1;
[curveParent1,~,~] = compute_curve_stage5(hObject,eventdata,handles,...
    handles.smoothing_param,bwParent1,1);
mergeCurve = compute_curve_stage5(hObject,eventdata,handles,...
    handles.smoothing_param,bwParent,1);
create_surface_element(hObject, eventdata, handles,curve1, curveParent1,...
    z1,z2,plotFlag);