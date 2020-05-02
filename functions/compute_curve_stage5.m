function [curve,handles,bw6] = compute_curve_stage5(hObject,eventdata,handles,smoothing_param,bw,i)
    bw = imopen(bw,strel('disk',2));
    bw6 = bwperim(bw);
    [a,b] = find(bw6,1);
    
    if ~isempty(a)
%     try
        [XY] = bwtraceboundary(bw6,[a,b],'E');
        X = XY(:,1);
        Y = XY(:,2);
        X2 = smooth(X,smoothing_param);
        Y2 = smooth(Y,smoothing_param);
        curve = [X2, Y2];
%     catch
%         handles = update_plot(hObject, eventdata, handles);
%         warndlg(['Failed to identify region in frame ' num2str(i) ...
%             '. Draw yourself or complain to Erlend.'])
%         handles = update_plot(hObject, eventdata, handles);
%         guidata(hObject,handles)
%         curve = [];
%         handles = update_plot(hObject, eventdata, handles);
%     end
    else
        curve = [];
    end
end