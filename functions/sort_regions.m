function handles = sort_regions(hObject, handles)

%% We want a binary matrix P with (num_slice-1) rows and num_region+1 columns, so that
% P(i,j) = 1 if and only if the curve of the jth region connects directly from
% slice i to i+1.

% We also want a binary vector B with num_region columns that says whether 
% the beginning of the region is a cap,
% and a binary vector E that does the same for the end of the region

num_slice = size(handles.I,3);
num_region = length(handles.smooth_extra); % Number of extra regions

P = zeros(num_slice-1,num_region+1); % Also consider main region
B = ones(num_region,1);
E = ones(num_region,1);
splits = cell(0);
mergers = cell(0);

%% Fix P
% Start with main region
P(handles.slice_start:handles.slice_end-1,1) = 1;

for j=1:num_region
    extra = handles.smooth_extra{j};
    
    % Do P
    P(extra.slice(1):extra.slice(2)-1,j+1) = 1;
    if extra.connect(1) > 0
        P(extra.slice(1)-1,extra.connect(1)) = 0;
        % Do B
        B(j) = 0;
    end
    if extra.connect(2) > 0
        P(extra.slice(2),extra.connect(2)) = 0;
        % Do E
        E(j) = 0;
    end
    
    % Do splits
    if extra.connect(1) > 0
        condition = true;% condition is true if new split
        i = extra.slice(1)-1; % Index of split
        k = extra.connect(1)-1; % Origin region (main is 0)
        for l=1:length(splits)
            if (splits{l}.ind == i) && (splits{l}.parent == k) % If pre-existing, add
                condition = false;
                splits{l}.children = [splits{l}.children, j];
            end
        end
        if condition % If pre-existing split
            splitsNew.ind = i;
            splitsNew.parent = k;
            splitsNew.children = j;
            splits = [splits, {splitsNew}];
        end
    end
    
    % Do mergers
    if extra.connect(2) > 0
        condition = true; % Condition remains true if new merge
        i = extra.slice(2); % Index of merge
        k = extra.connect(2)-1; % Origin region (main is 0)
        for l=1:length(mergers)
            if (mergers{l}.ind == i) && (mergers{l}.parent == k) % If pre-existing, add
                condition = false;
                mergers{l}.children = [mergers{l}.children, j];
            end
        end
        if condition % If pre-existing split
            mergersNew.ind = i;
            mergersNew.parent = k;
            mergersNew.children = j;
            mergers = [mergers, {mergersNew}];
        end
    end
end



handles.regStruct.P = P;
handles.regStruct.B = B;
handles.regStruct.E = E;
handles.regStruct.splits = splits;
handles.regStruct.mergers = mergers;

guidata(hObject,handles)