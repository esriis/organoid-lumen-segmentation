function handles = compute_curves(hObject,eventdata,handles,i,stage,smoothing_param)

    if stage <= 0
        dp = handles.denoise_param(i);
%         dp = 16;
        I_denoise_tmp = conv2(double(padarray(handles.I_box(:,:,i),[dp,dp],'both','symmetric')), ...
                ones(handles.denoise_param(i),handles.denoise_param(i)),'same');
        
        try
            handles.I_denoise(:,:,i) = I_denoise_tmp(dp+1:end-dp,dp+1:end-dp)...
            .*imclose((handles.I_box(:,:,i)~=0),strel('disk',1));
        catch
            figure; imagesc(handles.I_box(:,:,i)~=0)
        end

        Dx = zeros(size(handles.I_box,1)+1,size(handles.I_box,2)+1);
        Dy = zeros(size(Dx));

        Dx(1:end-1,2:end-1) = diff(handles.I_denoise(:,:,i),1,2);
        Dy(2:end-1,1:end-1) = diff(handles.I_denoise(:,:,i));
        handles.I_grad(:,:,i) = abs(Dx(1:end-1,1:end-1)) + abs(Dy(1:end-1,1:end-1));
        
        lambda = 1/4;
        
        handles.I_denoise(:,:,i) = lambda*handles.I_grad(:,:,i)/...
            mean(mean(mean(handles.I_grad(:,:,i))))...
            +(1-lambda)*handles.I_denoise(:,:,i)/...
            mean(mean(mean(handles.I_denoise(:,:,i))));
    end
%     if stage <= 1
    if stage <= 1
        I_max = max(max(max(handles.I_denoise(:,:,i))));
        I_min = min(min(min(handles.I_denoise(:,:,i))));
        I_tmp = squeeze(handles.I_denoise(:,:,i)/I_max);
        I_tmp = I_tmp(I_tmp>0); % Don't compute threshold for values that have been removed
        g = graythresh(I_tmp)*I_max; % Compute regular threshold
        threshold_val = (2*I_max+2*I_min - 4*g)*handles.threshold_param(i)^2 +...
            (4*g - 3*I_min - I_max)*handles.threshold_param(i) + I_min; % This gives
        % a good parametrisation from I_min to I_max for param from 0 to 1.
        handles.bw(:,:,i) = handles.I_denoise(:,:,i) >= threshold_val;
        handles.bw2(:,:,i) = imfill(handles.bw(:,:,i),'holes');
    end
    if stage <= 2
        handles.bw3(:,:,i) = bwareaopen(handles.bw2(:,:,i),...
            round(0.01*sum(sum(handles.bw2(:,:,i)))));
    end
    if stage <= 3
        
        bw3_tmp = handles.bw3(:,:,i);
        condition1 = sum(abs(bw3_tmp(:)))>0;
        
        while condition1
%             condition2 = true;
            bw_tmp_filt = bwareafilt(logical(bw3_tmp),1); % Extract largest region
            sum1 = sum(bw_tmp_filt,2);
            sum2 = sum(bw_tmp_filt,1);
            y1 = find(sum1,1);
            y2 = find(sum1,1,'last');
            x1 = find(sum2,1);
            x2 = find(sum2>0,1,'last');
            radius = max(y2-y1,x2-x1);
            if isempty(radius)
                radius = 0;
            end
            disk = max(1,round(handles.disk_param(i)*radius*7/4));
    %         disk = max(1,round(handles.disk_param(i)*(size(handles.bw3,1)...
    %             +size(handles.bw3,2))/2));
            bw_tmp_close = padarray(bw3_tmp,[disk disk],'both');
            bw_tmp_close = imopen(bw_tmp_close, strel('disk',1));  % This is
            % a dodgy addition to avoid single points messing with it
            bw_tmp_close = imclose(bw_tmp_close, strel('disk',disk));
            bw_tmp_close = imopen(bw_tmp_close, strel('disk',1)); 
            % ^ To avoid regions being connected by diagonal line.
            bw_tmp_close = bw_tmp_close((disk+1):(end-disk),...
                (disk+1):(end-disk));
            bw_tmp_close = imfill(bw_tmp_close,'holes');
            bw3_tmp = bw_tmp_close;
            bw_tmp_filt = bwareafilt(logical(bw_tmp_close),1); % Extract largest region
                        
            imCount = sum(bw3_tmp(:)); % Count total # of 1s
                
            edgeCount = sum(bw_tmp_filt(1,:)) + sum(bw_tmp_filt(end,:))...
                + sum(bw_tmp_filt(:,1)) + sum(bw_tmp_filt(:,end));
            pixelCount = sum(bw_tmp_filt(:)); % Add up stuff that's removed
            

            if edgeCount > 20 && pixelCount/imCount >= 0.999
%                     stop and raise the threshold..
                if handles.startFlag && handles.threshold_param(i) <= 0.98
                    % If at starting point, automatically adjust threshold
                    handles.threshold_param(i) = handles.threshold_param(i) + 0.02;
                    set(handles.threshold_value,'String',num2str(handles.threshold_param(i)))
                    set(handles.threshold_slider,'Value',handles.threshold_param(i))
%                     set(handles.threshold_slider,'Value',handles.threshold_param(i));
                    threshold_val = (2*I_max+2*I_min - 4*g)*handles.threshold_param(i)^2 +...
                        (4*g - 3*I_min - I_max)*handles.threshold_param(i) + I_min;
                    handles.bw(:,:,i) = handles.I_denoise(:,:,i) >= threshold_val;
                    handles.bw2(:,:,i) = imfill(handles.bw(:,:,i),'holes');
                    handles.bw3(:,:,i) = bwareaopen(handles.bw2(:,:,i),...
                    round(0.01*sum(sum(handles.bw2(:,:,i)))));
                    bw3_tmp = handles.bw3(:,:,i);
                else % If not at starting point, leave alone
                    condition1 = false;
                end
                
            elseif edgeCount > 20 % If too much of region borders to edge, remove that bit
                bw3_tmp = bw3_tmp - bw_tmp_filt;
                I_tmp = squeeze(handles.I_denoise(:,:,i)/I_max);
                I_tmp = I_tmp((I_tmp>0)&(bw3_tmp>0)); % Don't compute threshold
                % for values that have been removed
                g = graythresh(I_tmp)*I_max; % Compute regular threshold
            else
                condition1 = false;
            end
        end
        
        handles.bw4(:,:,i) = bw3_tmp;
        handles.bw4(:,:,i) = imfill(handles.bw4(:,:,i),'holes');
    end
    if stage <= 4
        % bw5 is the final binary image of the segmented region
        bw4_tmp = handles.bw4(:,:,i);
        if sum(abs(bw4_tmp(:))) > 0
            handles.bw5(:,:,i) = bwareafilt(logical(bw4_tmp),1);
        else
            handles.bw5(:,:,i) = logical(bw4_tmp);
        end
        handles.bw5(:,:,i) = handles.bw5(:,:,i).*logical(handles.bw3(:,:,i));
        disk = 2*disk;
        bw_tmp_close = padarray(handles.bw5(:,:,i),[disk disk],'both');
        bw_tmp_close = imclose(bw_tmp_close, strel('disk',disk));
        handles.bw5(:,:,i) = bw_tmp_close((disk+1):(end-disk),...
            (disk+1):(end-disk));
        handles.bw5(:,:,i) = imfill(handles.bw5(:,:,i),'holes');
        handles.bw_true(:,:,i) = handles.bw5(:,:,i);
    end
    if stage <= 5
        % bw6 traces the perimeter of bw5.
        [handles.smooth_perim{i},~,handles.bw6(:,:,i)] = ...
            compute_curve_stage5(hObject,eventdata,handles,smoothing_param,handles.bw5(:,:,i),i);  
        guidata(hObject,handles)
    end
end