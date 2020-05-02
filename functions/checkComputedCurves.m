function handles = checkComputedCurves(hObject,eventdata,handles)

    num_slice = length(handles.smooth_perim);
    
    %%
    
    missingFlag = false; % Check if at least one slice is missing
    i = 1;
    while ~missingFlag && i <= num_slice
        if isempty(handles.smooth_perim{i})
            missingFlag = true;
        end
        i = i+1;
    end
 
    %%
    if missingFlag
        allFlag = true; % Check if all slices are missing
        i = 1;
        while allFlag && i <= num_slice
            allFlag = isempty(handles.smooth_perim{i});
            i = i+1;
        end
        
        %% If all slices are missing
        if allFlag
            nx = size(handles.I_box,2);
            ny = size(handles.I_box,2);
            [x,y] = meshgrid(1:nx,1:ny);
            mask = (x-nx/2).^2 + (y-ny/2).^2 <= min(nx,ny)^2/4;
            for i = 1:num_slice
                handles.bw5(:,:,i) = mask;
                handles.bw_true(:,:,i) = handles.bw5(:,:,i);
                handles = compute_curves(hObject,eventdata,handles,i,5,handles.smoothing_param);
            end
        %% if not all slices are missing
        else
            % find first and last nonempty slices
            stopFlag = false;
            i = 1;
            while ~stopFlag
                if ~isempty(handles.smooth_perim{i})
                    slice1 = i;
                    stopFlag = true;
                end
                i = i+1;
            end
            
            stopFlag = false;
            i = num_slice;
            while ~stopFlag
                if ~isempty(handles.smooth_perim{i})
                    slice2 = i;
                    stopFlag = true;
                end
                i = i-1;
            end
            
            % Then set segmentations for slices 1, ..., slice1 -1 equal to
            % slice1
            for i = 1:(slice1-1)
                handles.bw5(:,:,i) = handles.bw5(:,:,slice1);
                handles.bw_true(:,:,i) = handles.bw5(:,:,i);
                handles = compute_curves(hObject,eventdata,handles,i,5,handles.smoothing_param);
            end
            
            % Set segs for slices slice2+1,...,num_slice equal to slice2.
            for i = slice2+1:num_slice
                handles.bw5(:,:,i) = handles.bw5(:,:,slice2);
                handles.bw_true(:,:,i) = handles.bw5(:,:,i);
                handles = compute_curves(hObject,eventdata,handles,i,5,handles.smoothing_param);
            end
            
            % Then interpolate for slices between two completed slices

            j = slice1+1;
            s1 = slice1;
            while j <= slice2
                if ~isempty(handles.smooth_perim{j})
                    s1 = j;
                    j = j+1;
                else
                    k = j+1;
                    while isempty(handles.smooth_perim{k})
                        k=k+1;
                    end
                    s2 = k;
                    % Do that thing between s1 and s2
                    
                    curve1 = handles.smooth_perim{s1};
                    curve2 = handles.smooth_perim{s2};
                    clen = max(size(curve1,1),size(curve2,1));
                    [curveInt1, curveInt2] = curveAlignment(curve1, curve2,clen);
                    for k = s1+1:s2-1
                        curve = (k-s1)/(s2-s1)*curveInt1...
                            + (s2-k)/(s2-s1)*curveInt2;
                        curve = round(curve);
                        curve(:,1) = max(min(curve(:,1),size(handles.I_box,1)),1);
                        curve(:,2) = max(min(curve(:,2),size(handles.I_box,2)),1);
                        
                        handles.bw5(:,:,k) = zeros(size(handles.I_box,1),size(handles.I_box,2));
                        for i=1:size(curve,1)
                            handles.bw5(curve(i,1),curve(i,2),k) = 1;
                            handles.bw5(curve(i,1)+1,curve(i,2),k) = 1;
                        end
                        handles.bw5(:,:,k) = imfill(handles.bw5(:,:,k),'holes');
                        handles.bw_true(:,:,k) = handles.bw5(:,:,k);
                        handles = compute_curves(hObject,eventdata,handles,k,5,handles.smoothing_param);
                    end
                    
                    s1 = s2;
                    j = s1+1;
                end
            end
        end
            
    end
   
            
    
end