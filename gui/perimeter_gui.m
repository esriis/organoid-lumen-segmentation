function varargout = perimeter_gui(varargin)
% PERIMETER_GUI MATLAB code for perimeter_gui.fig
%      PERIMETER_GUI, by itself, creates a new PERIMETER_GUI or raises the existing
%      singleton*.
%
%      H = PERIMETER_GUI returns the handle to a new PERIMETER_GUI or the handle to
%      the existing singleton*.
%
%      PERIMETER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PERIMETER_GUI.M with the given input arguments.
%
%      PERIMETER_GUI('Property','Value',...) creates a new PERIMETER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before perimeter_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to perimeter_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help perimeter_gui

% Last Modified by GUIDE v2.5 28-Sep-2019 22:27:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @perimeter_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @perimeter_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before perimeter_gui is made visible.
function perimeter_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to perimeter_gui (see VARARGIN)

% Choose default command line output for perimeter_gui
handles.output = hObject;

%% HERE ARE PARAMETERS YOU CAN CHANGE

handles.dx = 1/3.3724; % Units of voxel (in micrometer?)
handles.dy = 1/3.3724;
handles.dz = 8;



%%
handles.I = [];
handles.ratio_I = [];
handles.ratio_I_box = [];
handles.bw = [];
handles.bw2 = [];
handles.bw3 = [];
handles.bw4 = [];
handles.bw5 = [];
handles.bw_past = [];
handles.bw_true = [];
handles.bw6 = [];
handles.denoise_param = [];
handles.disk_param = [];
handles.I_box = [];
handles.I_box_full = [];
handles.I_grad = [];
handles.I_denoise = [];
handles.I_denoise_past = []; 
handles.image_plot = [];
handles.perim = [];
handles.rect = [];
handles.removal_param = [];
handles.slice_start = [];
handles.slice_end = [];
handles.slice_num = [];
handles.slice_start_full = [];
handles.slice_end_full = [];
handles.slice_num_full = [];
handles.smooth_perim = [];
handles.smooth_extra = cell(0);
handles.startFlag = true;
handles.surfaceArea = 0;
handles.threshold_param = [];
handles.undo_state = [];
handles.smoothing_param = 20;
handles.regStruct = [];

position = get(handles.figure1,'Position');
position(3) = 149.33333333333331;
position(4) = 43.07692307692308;
set(handles.figure1,'Position',position);

set(handles.image_axes,'XTick',[]);
set(handles.image_axes,'YTick',[]);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes perimeter_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = perimeter_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function filename_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function x1_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function x2_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function y1_value_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function y2_value_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function image_plot_list_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function threshold_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function threshold_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function slice_start_value_Callback(hObject, eventdata, handles)
function slice_start_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function slice_end_value_Callback(hObject, eventdata, handles)
function slice_end_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function filename_Callback(hObject, eventdata, handles)
function param_flag_Callback(hObject, eventdata, handles)
function rect_flag_Callback(hObject, eventdata, handles)
function extra_flag_Callback(hObject, eventdata, handles)

function load_images_Callback(hObject, eventdata, handles)

handles = loadImages(hObject, eventdata, handles);
guidata(hObject,handles)

function slider_Callback(hObject, eventdata, handles)

slice_index = round(get(handles.slider,'Value'));
set(handles.slider,'Value',slice_index)
i = slice_index-handles.slice_start+2; % Add 1 to adjust

if i < 1 || i > handles.slice_num
    set(handles.parameter_panel,'Visible','off')
else
    if get(handles.param_flag,'Value')
        set(handles.parameter_panel,'Visible','on')
        set(handles.threshold_slider,'Value',handles.threshold_param(i));
        set(handles.threshold_value,'String',num2str(handles.threshold_param(i)));

        if handles.undo_state(i) == 0
            set(handles.undo_button,'String','Undo')
            set(handles.undo_button,'Enable','off')
        elseif handles.undo_state(i) == 1
            set(handles.undo_button,'String','Undo')
            set(handles.undo_button,'Enable','on')
        elseif handles.undo_state(i) == 2
            set(handles.undo_button,'String','Restart')
            set(handles.undo_button,'Enable','on')
        end
    end
end

handles = update_plot(hObject, eventdata, handles);
guidata(hObject,handles)
try
    set(hObject, 'Enable', 'off');
    drawnow;
    set(hObject, 'Enable', 'on');
catch
end
    
%% Selecting region

function coordinate_button_Callback(hObject, eventdata, handles)
% For drawing rectangle region
set(handles.coordinate_panel,'Visible','off')
rect = round(getrect(handles.image_axes));
handles = update_plot(hObject, eventdata, handles);
if length(rect)==4
    rect(1) = max(rect(1),1);
    rect(2) = max(rect(2),1);
    rect(3) = min(rect(3), size(handles.I,2)-rect(1));
    rect(4) = min(rect(4), size(handles.I,1)-rect(2));
    handles.rect = rect;
    set(handles.restrict_button,'Visible','on')
end

handles = xy_update(hObject, eventdata, handles,'rect2xy');

set(handles.coordinate_panel,'Visible','on')
guidata(hObject,handles)

function x1_value_Callback(hObject, eventdata, handles)
if str2num(get(handles.x1_value,'String')) < 1
    set(handles.x1_value,'String',num2str(1))
end
handles = xy_update(hObject, eventdata, handles,'xy2rect');
guidata(hObject,handles)
    
function x2_value_Callback(hObject, eventdata, handles)
if str2num(get(handles.x2_value,'String')) > size(handles.I,2)
    set(handles.x2_value,'String',num2str(size(handles.I,2)))
end
handles = xy_update(hObject, eventdata, handles,'xy2rect');
guidata(hObject,handles)
    
function y1_value_Callback(hObject, eventdata, handles)
if str2num(get(handles.y1_value,'String')) < 1
    set(handles.y1_value,'String',num2str(1))
end
    
handles = xy_update(hObject, eventdata, handles,'xy2rect');
guidata(hObject,handles)
    
function y2_value_Callback(hObject, eventdata, handles)
if str2num(get(handles.y2_value,'String')) > size(handles.I,1)
    set(handles.y2_value,'String',num2str(size(handles.I,1)),'xy2rect')
end

handles = xy_update(hObject, eventdata, handles,'xy2rect');
guidata(hObject,handles)
    
function restrict_button_Callback(hObject, eventdata, handles)

x1 = str2num(get(handles.x1_value,'String'));
x2 = str2num(get(handles.x2_value,'String'));
y1 = str2num(get(handles.y1_value,'String'));
y2 = str2num(get(handles.y2_value,'String'));

% Adjust for extra index

% We add ones to move start index from 0 to 1
handles.slice_start = str2num(get(handles.slice_start_value,'String')) + 1;
handles.slice_start_full = handles.slice_start;
handles.slice_end = str2num(get(handles.slice_end_value,'String')) + 1;
handles.slice_end_full = handles.slice_end;
handles.slice_num = handles.slice_end - handles.slice_start + 1;
handles.slice_num_full = handles.slice_num;
if (isempty(x1) || isempty(x2) || isempty(y1) || isempty(y2))
    errordlg('Need to specify region.')
    return
end
if (~isnumeric(handles.slice_start)) || (isempty(handles.slice_start))...
        || (~isnumeric(handles.slice_end)) || (isempty(handles.slice_end))
    errordlg('Need to specify slice range')
    handles.slice_start = 0;
    handles.slice_start_full = handles.slice_start;
    return
end
set(handles.overlay_tick,'Value',0);

handles.I_box = handles.I(y1:y2,x1:x2,(handles.slice_start):(handles.slice_end));
handles.I_box_full = handles.I(y1:y2,x1:x2,:);

handles.ratio_I_box = size(handles.I_box,1)/size(handles.I_box,2);

if handles.slice_num > 1
    set(handles.slider,'Min',handles.slice_start_full-1)
    set(handles.slider,'Max',handles.slice_end_full-1)
    set(handles.slider,'Value',handles.slice_start_full-1)
    set(handles.slider,'SliderStep',[1/(handles.slice_num_full-1) 1/(handles.slice_num_full-1)])
else
    set(handles.slider,'Visible','off')
end

handles.denoise_param = 8*ones(handles.slice_num,1);
handles.threshold_param = 0.5*ones(handles.slice_num,1);
handles.removal_param = 120*ones(handles.slice_num,1);
handles.disk_param = 0.05*ones(handles.slice_num,1);

set(handles.threshold_slider,'Min',0)
set(handles.threshold_slider,'Max',1)
set(handles.threshold_slider,'Value',handles.threshold_param(1))
set(handles.threshold_slider,'SliderStep',[1/50 1/50])
set(handles.threshold_value,'String',num2str(handles.threshold_param(1)))

handles.I_denoise = zeros(size(handles.I_box));
handles.I_grad = zeros(size(handles.I_box));
handles.bw = zeros(size(handles.I_box));
handles.bw2 = zeros(size(handles.I_box));
handles.bw3 = zeros(size(handles.I_box));
handles.bw4 = zeros(size(handles.I_box));
handles.bw5 = zeros(size(handles.I_box));
handles.bw_past = zeros(size(handles.I_box));
handles.bw_true = zeros(size(handles.I_box));
handles.bw6 = zeros(size(handles.I_box));
handles.I_denoise_past = zeros(size(handles.I_box));
handles.smooth_perim = cell(handles.slice_num,1);
% handles.smooth_extra = cell(slice_num,1);
handles.perim = zeros(1,handles.slice_num);
handles.undo_state = zeros(handles.slice_num,1);
handles.startFlag = true;

hbar = waitbar(0,'Processing');
for i = 1:handles.slice_num
    waitbar(i/handles.slice_num,hbar)
    handles = compute_curves(hObject,eventdata,handles,i,0,handles.smoothing_param);
%     handles.smooth_extra{i} = cell(1);
end

handles = checkComputedCurves(hObject,eventdata,handles);



handles.image_plot = handles.bw5;

handles.startFlag = false;

set(handles.image_plot_list,'Value',3)
handles = update_plot(hObject, eventdata, handles);

set(handles.coordinate_panel,'Visible','off')
% set(handles.go_back_button,'Visible','on')
% set(handles.visualise_button,'Visible','on')
% set(handles.spreadsheet_button,'Visible','on')
set(handles.image_plot_list,'Visible','on')
set(handles.overlay_tick,'Visible','on')
position_tmp = get(handles.coordinate_panel,'Position');
position = get(handles.parameter_panel,'Position');
position(1) = position_tmp(1)-4;
position(2) = position_tmp(2) + position_tmp(4) - position(4);
set(handles.parameter_panel,'Position',position)
set(handles.parameter_panel,'Visible','on')

if ~get(handles.extra_flag,'Value')
    position_coord = position;
    position = get(handles.main_panel,'Position');
    % position_tmp = position_coord;
    position(1) = position_coord(1);
    position(2) = position_coord(2) - position(4)-3;
    set(handles.main_panel,'Position',position)
    set(handles.main_panel,'Visible','on')
else
    set(handles.store_extra_button,'Visible','on')
end



set(handles.undo_button,'Enable','off')
set(handles.param_flag,'Value',1)
set(handles.rect_flag,'Value',0)

close(hbar)

set(handles.overlay_tick,'Value',1);
handles = update_plot(hObject, eventdata, handles);


drawnow
guidata(hObject,handles)


%% Add buttons

function add_button_Callback(hObject, eventdata, handles)
set(handles.parameter_panel,'Visible','off')
handles = add_point(hObject, eventdata, handles);
handles = update_plot(hObject, eventdata, handles);
set(handles.parameter_panel,'Visible','on')
guidata(hObject,handles)

function draw_add_button_Callback(hObject, eventdata, handles)
set(handles.parameter_panel,'Visible','off')
handles = add_region(hObject, eventdata, handles);
set(handles.parameter_panel,'Visible','on')
guidata(hObject,handles)

function draw_yourself_button_Callback(hObject, eventdata, handles)
set(handles.parameter_panel,'Visible','off')
handles = draw_yourself(hObject, eventdata, handles);
handles = update_plot(hObject, eventdata, handles);
set(handles.parameter_panel,'Visible','on')
guidata(hObject,handles)


%% Removal buttons

function restrict_box_button_Callback(hObject, eventdata, handles)
set(handles.parameter_panel,'Visible','off')
handles = restrict_box(hObject, eventdata, handles);
handles = update_plot(hObject, eventdata, handles);
set(handles.parameter_panel,'Visible','on')
guidata(hObject,handles)

function remove_current_button_Callback(hObject, eventdata, handles)
set(handles.parameter_panel,'Visible','off')
handles = remove_current(hObject, eventdata, handles);
handles = update_plot(hObject, eventdata, handles);
set(handles.parameter_panel,'Visible','on')
guidata(hObject,handles)

function remove_box_button_Callback(hObject, eventdata, handles)
set(handles.parameter_panel,'Visible','off')
handles = remove_box(hObject, eventdata, handles);
handles = update_plot(hObject, eventdata, handles);
set(handles.parameter_panel,'Visible','on')
guidata(hObject,handles)

function draw_removal_button_Callback(hObject, eventdata, handles)
set(handles.parameter_panel,'Visible','off')
handles = remove_region(hObject, eventdata, handles);
handles = update_plot(hObject, eventdata, handles);
set(handles.parameter_panel,'Visible','on')
guidata(hObject,handles)



%% Misc


function image_plot_list_Callback(hObject, eventdata, handles)
handles = update_plot(hObject, eventdata, handles);
guidata(hObject,handles)

function overlay_tick_Callback(hObject, eventdata, handles)
handles = update_plot(hObject, eventdata, handles);
guidata(hObject,handles)

function threshold_slider_Callback(hObject, eventdata, handles)
hbar = waitbar(0,'Processing');
slice_index = get(handles.slider,'Value');
i = slice_index-handles.slice_start+2;
handles.threshold_param(i) = get(handles.threshold_slider,'Value');
set(handles.threshold_value,'String',num2str(handles.threshold_param(i)));
drawnow
handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
handles = update_plot(hObject, eventdata, handles);
close(hbar)
handles = update_plot(hObject, eventdata, handles);
guidata(hObject,handles)

try
    set(hObject, 'Enable', 'off');
    drawnow;
    set(hObject, 'Enable', 'on');
catch
end

function threshold_value_Callback(hObject, eventdata, handles)
slice_index = get(handles.slider,'Value');
i = slice_index-handles.slice_start+2;
tmp_val = str2num(get(handles.threshold_value,'String'));
if tmp_val <=1 && tmp_val >=0
    handles.threshold_param(i) = tmp_val;
    set(handles.threshold_slider,'String',num2str(handles.threshold_param(i)));
elseif tmp_val > 1
    handles.threshold_param(i) = 1;
    set(handles.threshold_value,'String',num2str(1))
elseif tmp_val < 0
    handles.threshold_param(i) = 0;
    set(handles.threshold_value,'String',num2str(0))
end

handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
handles = update_plot(hObject, eventdata, handles);
guidata(hObject,handles)

function undo_button_Callback(hObject, eventdata, handles)

slice_index = get(handles.slider,'Value');
i = slice_index-handles.slice_start+2;

if handles.undo_state(i) == 1
    handles.undo_state(i) = 2;
    handles.bw5(:,:,i) = handles.bw_past(:,:,i);
    handles = compute_curves(hObject,eventdata,handles,i,5,handles.smoothing_param);
    handles = update_plot(hObject, eventdata, handles);
    set(handles.undo_button,'String','Restart')
elseif handles.undo_state(i) == 2
    handles.bw5(:,:,i) = handles.bw_true(:,:,i);
    handles = compute_curves(hObject,eventdata,handles,i,0,handles.smoothing_param);
    handles = update_plot(hObject, eventdata, handles);
%     handles.smooth_extra{i} = cell(1);
    handles.undo_state(i) = 0;
    set(handles.undo_button,'String','Undo')
    set(handles.undo_button,'Enable','off')
elseif handles.undo_state(i) == 3
    handles.undo_state(i) = 2;
    handles.bw5(:,:,i) = handles.bw_past(:,:,i);
%     handles.smooth_extra{i} = cell(1);
    handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
    handles = update_plot(hObject, eventdata, handles);
    set(handles.undo_button,'String','Restart')
elseif handles.undo_state(i) == 4
    handles.undo_state(i) = 2;
    handles.bw5(:,:,i) = handles.bw_past(:,:,i);
%     handles.smooth_extra{i} = cell(1);
    handles = compute_curves(hObject,eventdata,handles,i,0,handles.smoothing_param);
    handles = update_plot(hObject, eventdata, handles);
    set(handles.undo_button,'String','Restart')
elseif handles.undo_state(i) == 5
    handles.undo_state(i) = 2;
    handles.I_denoise(:,:,i) = handles.I_denoise_past(:,:,i);
%     handles.smooth_extra{i} = cell(1);
    handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
    handles = update_plot(hObject, eventdata, handles);
    set(handles.undo_button,'String','Restart')
end
guidata(hObject,handles)
       
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)

if length(eventdata.Modifier) == 1
    if strcmp(eventdata.Modifier,'command') && get(handles.param_flag,'Value')
        switch eventdata.Key
            case 'a'
                draw_add_button_Callback(hObject, eventdata, handles)
            case 'c'
                add_button_Callback(hObject, eventdata, handles)
            case 'e'
                draw_removal_button_Callback(hObject, eventdata, handles)
            case 'f'
                handles = draw_yourself_button_Callback(hObject, eventdata, handles);
            case 'p'
                export_button_Callback(hObject, eventdata, handles)
            case 's'
                separate_button_Callback(hObject, eventdata, handles)
            case 'r'
                restrict_box_button_Callback(hObject, eventdata, handles)
            case 'z'
                undo_button_Callback(hObject, eventdata, handles)
        end
    end
end

switch eventdata.Key
    case 'leftarrow'
        slice_index = get(handles.slider,'Value');
        slice_index = max(slice_index-1,handles.slice_start_full-1);
        set(handles.slider,'Value',slice_index)
        slider_Callback(hObject, eventdata, handles)
    case 'rightarrow'
        slice_index = get(handles.slider,'Value');
        slice_index = min(slice_index+1,handles.slice_end_full-1);
        set(handles.slider,'Value',slice_index)
        slider_Callback(hObject, eventdata, handles)
    case 'downarrow'
        if get(handles.param_flag,'Value')
            hbar = waitbar(0,'Processing');
            slice_index = get(handles.slider,'Value');
            i = slice_index-handles.slice_start+2;
            tmp_val = get(handles.threshold_slider,'Value');
            tmp_val = max(0,tmp_val - 1/50);
            handles.threshold_param(i) = tmp_val;
            set(handles.threshold_slider,'Value',tmp_val)
            set(handles.threshold_value,'String',num2str(tmp_val))
            drawnow
            handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
            close(hbar)
            handles = update_plot(hObject, eventdata, handles);
        end
    case 'uparrow'
        if get(handles.param_flag,'Value')
            hbar = waitbar(0,'Processing');
            slice_index = get(handles.slider,'Value');
            i = slice_index-handles.slice_start+2;
            tmp_val = get(handles.threshold_slider,'Value');
            tmp_val = min(1,tmp_val + 1/50);
            handles.threshold_param(i) = tmp_val;
            set(handles.threshold_slider,'Value',tmp_val)
            set(handles.threshold_value,'String',num2str(tmp_val))
            drawnow
            handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
            close(hbar)
            handles = update_plot(hObject, eventdata, handles);
        end
end
guidata(hObject,handles)

function follow_slice_button_Callback(hObject, eventdata, handles)

slice_index = get(handles.slider,'Value');
i_start = slice_index-handles.slice_start+2;

overlapPercentage = 0.2;

hbar = waitbar(0,'Processing');
for i = i_start+1:handles.slice_num
    waitbar((i-i_start)/(handles.slice_num-i_start),hbar)
    handles = compute_curves(hObject,eventdata,handles,i,0,handles.smoothing_param);
    bwOverlap = 2*handles.bw5(:,:,i-1)+handles.bw5(:,:,i);
    k = sum(bwOverlap(:)==3);
    while k/(min(sum(bwOverlap(:)==1),sum(bwOverlap(:)==2))+k) < overlapPercentage
        % While overlap is insufficient
        handles.bw_past(:,:,i) = handles.bw5(:,:,i);
        handles.I_denoise_past(:,:,i) = handles.I_denoise(:,:,i);
        handles.I_denoise(:,:,i) = handles.I_denoise(:,:,i).*...
            (handles.bw5(:,:,i)==0)-(handles.bw5(:,:,i)==1);
        handles.startFlag = true;
        handles = compute_curves(hObject,eventdata,handles,i,1,handles.smoothing_param);
        bwOverlap = 2*handles.bw5(:,:,i-1)+handles.bw5(:,:,i);
        k = sum(bwOverlap(:)==3);
    end
end
handles.startFlag = false;

handles = update_plot(hObject, eventdata, handles);
close(hbar)

drawnow
guidata(hObject,handles)

function restart_button_Callback(hObject, eventdata, handles)
close perimeter_gui
perimeter_gui

%% Extra region controls

function separate_button_Callback(hObject, eventdata, handles)

handles.handles = handles; % Store prev info.

%% Create new I (all slices, but same x,y values)
x1 = str2num(get(handles.x1_value,'String'));
x2 = str2num(get(handles.x2_value,'String'));
y1 = str2num(get(handles.y1_value,'String'));
y2 = str2num(get(handles.y2_value,'String'));
handles.I = handles.I(y1:y2,x1:x2,:);

% Remove previous values
% First for main region
handles.I(:,:,handles.slice_start:handles.slice_end) = ...
    handles.I(:,:,handles.slice_start:handles.slice_end).*(1-handles.handles.bw5);
% Then for other regions
for j=1:length(handles.smooth_extra)
    extra = handles.smooth_extra{j};
    handles.I(:,:,extra.slice(1):extra.slice(2)) = ...
        handles.I(:,:,extra.slice(1):extra.slice(2)).*(1-extra.binary);
end
    
% Restart slice start and ends
handles.slice_start = 1;
handles.slice_end = size(handles.I,3);
handles.slice_start_full = handles.slice_start;
handles.slice_end_full = handles.slice_end;
handles.slice_num = handles.slice_end - handles.slice_start + 1;
handles.slice_num_full = handles.slice_num;


% Update slider
if handles.slice_num > 1
    set(handles.slider,'Min',handles.slice_start-1)
    set(handles.slider,'Max',handles.slice_end-1)
    set(handles.slider,'SliderStep',[1/(handles.slice_num-1) 1/(handles.slice_num-1)])
else
    set(handles.slider,'Visible','off')
end

%%

handles.ratio_I = handles.handles.ratio_I_box;
handles.rect = [];
set(handles.image_plot_list,'Value',2);
handles = xy_update(hObject, eventdata, handles,'rect2xy');

% Why are we moving the figure like this?
position_tmp = get(handles.figure1,'Position');
position = position_tmp;
position(3) = 149.33333333333331;
position(4) = 43.07692307692308;
set(handles.figure1,'Position',position);

set(handles.image_axes,'XTick',[]);
set(handles.image_axes,'YTick',[]);
set(handles.overlay_tick,'Value',0)
set(handles.param_flag,'Value',0)

position_tmp = get(handles.load_panel,'Position');
position = get(handles.coordinate_panel,'Position');
position(1) = position_tmp(1);
position(2) = position_tmp(2) + position_tmp(4) - position(4);
set(handles.coordinate_panel,'Position',position)
set(handles.coordinate_panel,'Visible','on')

position_coord = position;
position = get(handles.extra_panel,'Position');
% position_tmp = position_coord;
position(1) = position_coord(1);
position(2) = position_coord(2) - position(4)-3;
set(handles.extra_panel,'Position',position)
set(handles.extra_panel,'Visible','on')
set(handles.store_extra_button,'Visible','off')

set(handles.image_plot_list,'Visible','off')
set(handles.overlay_tick,'Visible','off')
set(handles.parameter_panel,'Visible','off')
set(handles.main_panel,'Visible','off')

slice_index = get(handles.slider,'Value')-handles.slice_start+1;
handles.slice_start = 1; % Is this bad?
handles.slice_end = size(handles.I,3);

% set(handles.slider,'Min',0)
% set(handles.slider,'Value',slice_index)
% set(handles.slider,'Max',handles.slice_num-1)
% if handles.slice_num > 1
%     set(handles.slider,'SliderStep',[1/(handles.slice_num-1) 1/(handles.slice_num-1)])
%     set(handles.slider,'Visible','on')
% end

set(handles.image_plot_list,'Value',2)
handles = update_plot(hObject,eventdata,handles);

set(handles.extra_flag,'Value',1)
guidata(hObject,handles)

function store_extra_button_Callback(hObject, eventdata, handles)
    pos = handles.rect; % Store position of extra region
    slice = [handles.slice_start, handles.slice_end];
    num_slice = slice(2) - slice(1) + 1;
    slice_main = [handles.handles.slice_start, handles.handles.slice_end];

    % Get coordinates to compare with main region
    x1 = pos(1);
    x2 = pos(1)+pos(3);
    y1 = pos(2);
    y2 = pos(2)+pos(4);

    % Store binary image, for overlap checks.
    binary = zeros([size(handles.I,1),size(handles.I,2),num_slice]);
    binary(y1:y2,x1:x2,:) = handles.bw5; 

    %% Check there is no overlap with regions

    binaryFull = zeros(size(handles.I));
    binaryFull(:,:,slice(1):slice(2)) = binary;

    bw5 = zeros(size(binaryFull));
    bw5(:,:,slice_main(1):slice_main(2)) = handles.handles.bw5;

    binaryOld = binaryFull;
    binaryFull = binaryFull.*(1-bw5);
    for j = 1:length(handles.smooth_extra)
        extra = handles.smooth_extra{j};
        binaryExtra = zeros(size(binaryFull));
        binaryExtra(:,:,extra.slice(1):extra.slice(2)) = extra.binary;
        binaryFull = binaryFull.*(1-binaryExtra);
    end
    if any(binaryFull(:) ~= binaryOld(:))
        warndlg('Overlap of new region with preexisting region has been detected and removed.')
    end

    binary = binaryFull(:,:,slice(1):slice(2));

    % Update curves again
    handles.bw5 = binary(y1:y2,x1:x2,:);

    for i = 1:size(handles.bw5,3)
        handles = compute_curves(hObject,eventdata,handles,i,5,handles.smoothing_param);
    end


    %%

    % Check if beginning of region is connected to main region or
    % other region
    smooth_extra.connect = zeros(1,2);
    overPerc = 0.05;

    % check if begins 

    binaryFull = zeros(size(handles.I));
    binaryFull(:,:,slice(1):slice(2)) = binary;

    if slice(1)>1
        condition = false;
        if slice(1) > slice_main(1)
            bw5 = zeros(size(binaryFull));
            bw5(:,:,slice_main(1):slice_main(2)) = handles.handles.bw5;
            overlap = sum(sum(bw5(:,:,slice(1)-1) & binaryFull(:,:,slice(1))));
            if overlap/max(1,min(sum(sum(bw5(:,:,slice(1)-1))),sum(sum(binaryFull...
                    (:,:,slice(1)))))) >= overPerc
                smooth_extra.connect(1) = 1;
                condition = true;
            end
        end

        j=1;
        while ~condition && length(handles.smooth_extra) >= j
            extra = handles.smooth_extra{j};
            bw5 = zeros(size(binaryFull));
            bw5(:,:,extra.slice(1):extra.slice(2)) = extra.binary;
            overlap = sum(sum(bw5(:,:,slice(1)-1) & binaryFull(:,:,slice(1))));
            if overlap/max(1,min(sum(sum(bw5(:,:,slice(1)-1))),sum(sum(binaryFull...
                    (:,:,slice(1)))))) >= overPerc
                smooth_extra.connect(1) = j+1;
                condition = true;
            end
            j=j+1;
        end
    end

    % Check if end of region is connected to main region or
    % other region

    if slice(2) < size(handles.I,3)
        condition = false;
        if slice(2) < slice_main(2)
            bw5 = zeros(size(binaryFull));
            bw5(:,:,slice_main(1):slice_main(2)) = handles.handles.bw5;
            overlap = sum(sum(bw5(:,:,slice(2)-1) & binaryFull(:,:,slice(2))));
            if overlap/max(1,min(sum(sum(bw5(:,:,slice(2)-1))),sum(sum(binaryFull...
                    (:,:,slice(2)))))) >= overPerc
                smooth_extra.connect(2) = 1;
                condition = true;
            end
        end

        j=1;
        while ~condition && length(handles.smooth_extra) >= j
            extra = handles.smooth_extra{j};
            bw5 = zeros(size(binaryFull));
            bw5(:,:,extra.slice(1):extra.slice(2)) = extra.binary;
            overlap = sum(sum(bw5(:,:,slice(2)-1) & binaryFull(:,:,slice(2))));
            if overlap/max(1,min(sum(sum(bw5(:,:,slice(2)-1))),sum(sum(binaryFull(...
                    :,:,slice(2)))))) >= overPerc
                smooth_extra.connect(2) = j+1;
                condition = true;
            end
            j=j+1;
        end
    end

    if sum(smooth_extra.connect)==0
        warndlg('This additional region is registered as disconnected from main region.')
    end


    %% Store slice numbers

    perim = handles.smooth_perim;
    for i=1:num_slice % Translate by position of rect
         perim{i} = perim{i} + [pos(2),pos(1)];
    end

    smooth_extra.perim = perim;
    smooth_extra.slice = slice;
    smooth_extra.binary = binary;
    smooth_extra.slice_num = num_slice;

    handles = update_plot(hObject, eventdata, handles);
    guidata(hObject,handles)
    handles = update_plot(hObject, eventdata, handles);
    handles.handles.smooth_extra = [handles.handles.smooth_extra, smooth_extra];  % Store data
    handles.handles.slice_start_full = min(handles.handles.slice_start_full, slice(1));
    handles.handles.slice_end_full = max(handles.handles.slice_end_full, slice(2));
    handles.handles.slice_num_full = handles.handles.slice_end_full-...
        handles.handles.slice_start_full+1;

    cancel_extra_button_Callback(hObject, eventdata, handles) % Run default code

    
    

function cancel_extra_button_Callback(hObject, eventdata, handles)
handles = handles.handles; % Store prev info.
set(handles.slice_start_value,'String',num2str(handles.slice_start-1))
set(handles.slice_end_value,'String',num2str(handles.slice_end-1))
set(handles.slider,'Min',handles.slice_start_full-1)
set(handles.slider,'Max',handles.slice_end_full-1)
set(handles.slider,'Value',handles.slice_start_full-1)
if handles.slice_num_full > 1
    set(handles.slider,'SliderStep',[1/(handles.slice_num_full-1) 1/(handles.slice_num_full-1)])
    set(handles.slider,'Visible','on')
end


handles = xy_update(hObject, eventdata, handles,'rect2xy');

if handles.slice_num > 1
    set(handles.slider,'Min',handles.slice_start_full-1)
    set(handles.slider,'Max',handles.slice_end_full-1)
    set(handles.slider,'Value',handles.slice_start_full-1)
    set(handles.slider,'SliderStep',[1/(handles.slice_num_full-1) 1/(handles.slice_num_full-1)])
else
    set(handles.slider,'Visible','off')
end

set(handles.image_plot_list,'Value',3)
handles = update_plot(hObject, eventdata, handles);

set(handles.coordinate_panel,'Visible','off')
% set(handles.go_back_button,'Visible','on')
% set(handles.visualise_button,'Visible','on')
% set(handles.spreadsheet_button,'Visible','on')
set(handles.image_plot_list,'Visible','on')
set(handles.overlay_tick,'Visible','on')
position_tmp = get(handles.coordinate_panel,'Position');
position = get(handles.parameter_panel,'Position');
position(1) = position_tmp(1)-4;
position(2) = position_tmp(2) + position_tmp(4) - position(4);
set(handles.parameter_panel,'Position',position)
set(handles.parameter_panel,'Visible','on')
set(handles.extra_panel,'Visible','off')
set(handles.extra_flag,'Value',0)

if ~get(handles.extra_flag,'Value')
    position_coord = position;
    position = get(handles.main_panel,'Position');
    % position_tmp = position_coord;
    position(1) = position_coord(1);
    position(2) = position_coord(2) - position(4)-3;
    set(handles.main_panel,'Position',position)
    set(handles.main_panel,'Visible','on')
else
    set(handles.store_extra_button,'Visible','on')
end



set(handles.undo_button,'Enable','off')
set(handles.param_flag,'Value',1)
set(handles.rect_flag,'Value',0)

set(handles.overlay_tick,'Value',1);
handles = update_plot(hObject, eventdata, handles);

if handles.slice_num > 1
    set(handles.slider,'Min',handles.slice_start_full-1)
    set(handles.slider,'Max',handles.slice_end_full-1)
    set(handles.slider,'Value',handles.slice_start_full-1)
    set(handles.slider,'SliderStep',[1/(handles.slice_num_full-1) 1/(handles.slice_num_full-1)])
    set(handles.slider,'Visible','on')
else
    set(handles.slider,'Visible','off')
end

drawnow
guidata(hObject,handles)
 

%% Main controls

function mat_button_Callback(hObject, eventdata, handles)
store_mat(hObject, eventdata, handles)
guidata(hObject,handles)

function spreadsheet_button_Callback(hObject, eventdata, handles)
handles = sort_regions(hObject,handles);
handles = create_spreadsheet(hObject, eventdata, handles);
guidata(hObject,handles)

function visualise_button_Callback(hObject, eventdata, handles)

plotFlag = true;
handles = sort_regions(hObject,handles);
handles = create_surface(hObject, eventdata, handles,plotFlag);
% createNewSurfaceAlt(handles)
guidata(hObject,handles)

function go_back_button_Callback(hObject, eventdata, handles)

% Delete extra region information
handles.smooth_extra = cell(0);

% Reposition stuff
position_tmp = get(handles.figure1,'Position');
position = position_tmp;
position(3) = 149.33333333333331;
position(4) = 43.07692307692308;
set(handles.figure1,'Position',position);

% Sort figure visuals and ticks
set(handles.image_axes,'XTick',[]);
set(handles.image_axes,'YTick',[]);
% set(handles.overlay_tick,'Value',0)
set(handles.param_flag,'Value',0)


% Reposition more and make things (in)visible
position_tmp = get(handles.load_panel,'Position');
position = get(handles.coordinate_panel,'Position');
position(1) = position_tmp(1);
position(2) = position_tmp(2) + position_tmp(4) - position(4);
set(handles.coordinate_panel,'Position',position)
set(handles.coordinate_panel,'Visible','on')
set(handles.image_plot_list,'Visible','off')
set(handles.overlay_tick,'Visible','off')
set(handles.parameter_panel,'Visible','off')
set(handles.main_panel,'Visible','off')


slice_index = get(handles.slider,'Value');
handles.slice_start = 1;
handles.slice_start_full = handles.slice_start;
handles.slice_end = size(handles.I,3);
handles.slice_end_full = handles.slice_end;
handles.slice_num = handles.slice_end - handles.slice_start + 1;
handles.slice_num_full = handles.slice_num;

set(handles.slider,'Min',handles.slice_start_full-1)
set(handles.slider,'Max',handles.slice_end_full-1)
set(handles.slider,'Value',slice_index)
if handles.slice_num > 1
    set(handles.slider,'SliderStep',[1/(handles.slice_num_full-1) 1/(handles.slice_num_full-1)])
    set(handles.slider,'Visible','on')
end

set(handles.image_plot_list,'Value',2)
handles = update_plot(hObject,eventdata,handles);
guidata(hObject,handles)
