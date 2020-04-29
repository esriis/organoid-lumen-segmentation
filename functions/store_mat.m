function store_mat(hObject, eventdata, handles)






handlesInfo = whos('handles');

handlesTmp = handles;
clear handles
handlesZip.y2_value = handlesTmp.y2_value;
handlesZip.y1_value = handlesTmp.y1_value;
handlesZip.x2_value = handlesTmp.x2_value;
handlesZip.x1_value = handlesTmp.x1_value;
handlesZip.dx = handlesTmp.dx;
handlesZip.dy = handlesTmp.dy;
handlesZip.dz = handlesTmp.dz;
handlesZip.bw5 = handlesTmp.bw5;
handlesZip.denoise_param = handlesTmp.denoise_param;
handlesZip.disk_param = handlesTmp.disk_param;
handlesZip.perim = handlesTmp.perim;
handlesZip.removal_param = handlesTmp.removal_param;
handlesZip.slice_start = handlesTmp.slice_start;
handlesZip.slice_end = handlesTmp.slice_end;
handlesZip.smooth_perim = handlesTmp.smooth_perim;
handlesZip.smooth_extra = handlesTmp.smooth_extra;
handlesZip.surfaceArea = handlesTmp.surfaceArea;
handlesZip.threshold_param = handlesTmp.threshold_param;
handlesZip.smoothing_param = handlesTmp.smoothing_param;
handlesZip.regStruct = handlesTmp.regStruct;

zipInfo = whos('handlesZip');


filename = 'data';
mydlg = warndlg(['The size of the .mat file would be approximately ' ...
        num2str(round(100*zipInfo.bytes/2/10^6)/100) ' MB.']);
waitfor(mydlg)
[file,path,indx] = uiputfile([filename '.mat']);

if indx
    save([path file],'handlesZip')
end