function handles = merger_function(hObject,eventdata,handles,merger,ind1,ind2,plotFlag,mode)

%%

num_slice = size(handles.I,3);

if merger.parent == 0
    smooth_perim = cell(num_slice,1);
    smooth_perim(handles.slice_start:handles.slice_end) = handles.smooth_perim;
    curve2 = smooth_perim{ind2};
    bwParent = zeros(size(handles.I_box,1),size(handles.I_box,2),num_slice);
    bwParent(:,:,handles.slice_start:handles.slice_end) = handles.bw5;
    bwParent = bwParent(:,:,ind2);
else
    extra = handles.smooth_extra{merger.parent};
    smooth_extra = cell(num_slice,1);
    smooth_extra(extra.slice(1):extra.slice(2)) = extra.perim;
    curve2 = smooth_extra{ind2};
    bwParent = zeros(size(handles.I_box,1),size(handles.I_box,2),num_slice);
    bwParent(:,:,extra.slice(1):extra.slice(2)) = extra.binary;
    bwParent = bwParent(:,:,ind2);
end
pixParent = sum(bwParent(:));

% Create index matrix
indX = (1:size(bwParent,1))'*ones(1,size(bwParent,2));
indY = (1:size(bwParent,2))'*ones(1,size(bwParent,1));
indY = indY';
bwInd = cat(3,indX,indY);

num_kids = length(merger.children);

% Count total number of pixels to compare relative sizes
pixCount = 0;
for j=1:num_kids
    extra = handles.smooth_extra{merger.children(j)};
    binary = zeros(size(handles.I_box,1),size(handles.I_box,2),num_slice);
    binary(:,:,extra.slice(1):extra.slice(2)) = extra.binary;
    if strcmp(mode,'split')
        extra.slice = [extra.slice(2), extra.slice(1)];
    end
    pixCount = pixCount + sum(sum(binary(:,:,extra.slice(2))));
end
if merger.parent == 0
    bw5 = zeros(size(handles.I_box,1),size(handles.I_box,2),num_slice);
    bw5(:,:,handles.slice_start:handles.slice_end) = handles.bw5;
    pixCount = pixCount + sum(sum(bw5(:,:,ind1)));
else
    extra = handles.smooth_extra{merger.parent};
    binary = zeros(size(handles.I_box,1),size(handles.I_box,2),num_slice);
    binary(:,:,extra.slice(1):extra.slice(2)) = extra.binary;
    if strcmp(mode,'split')
        extra.slice = [extra.slice(2), extra.slice(1)];
    end
    pixCount = pixCount + sum(sum(binary(:,:,extra.slice(2))));
end

% For each kid, compute relative size and steal it.
for j=1:num_kids
    extra = handles.smooth_extra{merger.children(j)};
    binary = zeros(size(handles.I_box,1),size(handles.I_box,2),num_slice);
    binary(:,:,extra.slice(1):extra.slice(2)) = extra.binary;
    bwChild = binary(:,:,ind1);
    ratioGoal = sum(bwChild(:))/pixCount;
    
    perim = cell(num_slice,1);
    perim(extra.slice(1):extra.slice(2)) = extra.perim;
    curve1 = perim{ind1};

    [bwParent,mergeCurve,handles] = compute_merger(hObject, eventdata, handles,...
        curve1, curve2, bwParent,bwInd,ratioGoal,pixParent,ind1,ind2,plotFlag);
    handles.smooth_extra{merger.children(j)}.merger = mergeCurve;
end

% Also do the above for the parent.
if merger.parent == 0
    curve1 = smooth_perim{ind1};
%     bwChild = handles.bw5(:,:,ind1);
else
    curve1 = smooth_extra{merger.parent}.perim{ind1};
%     bwChild = handles.smooth_extra{merger.parent}.binary(:,:,ind1);
end

create_surface_element(hObject, eventdata, handles,curve1, mergeCurve,...
    ind1,ind2,plotFlag);

% ratioGoal = sum(bwChild(:))/pixCount;
% [~,~,handles] = compute_merger(hObject, eventdata, handles,curve1,...
%     curve2, bwParent,bwInd,ratioGoal,pixParent,ind1,ind2,plotFlag);

end