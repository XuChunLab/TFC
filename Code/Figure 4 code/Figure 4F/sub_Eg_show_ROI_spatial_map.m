% Example to create cell maps of selected ROIs
% In this example, you will see maps for shock_activated cells, shock
% inhibited cells, non-responsve cells, and the overlay.
%
% Modify the script to set the color for the cells as you like.
% After the figure created, you could save them into TIFF files and modify
% them in the ImageJ, and eventually organize them in the Illustartor.
%
% XuChun, March 12, 2021
%clc;clear;
% require function <colorGradient>, <RGB>

% load example data [processed_xxxx.mat]
load('processed_206775.mat'); 
%load ('habi_sdff_cell.mat');
%load('habituation_data')
%% habituation session
figname='example'; % figure name
%shock_cell=sdff_shock{6};
tone_cell=tone_final{7};
trace_cell=trace_final{7};
overlap=intersect(tone_cell,trace_cell);
tone_only=setdiff(tone_cell,overlap);
trace_only=setdiff(trace_cell,overlap);
cs_trace_activated_id=habi_persistent3{7};
rule_out1=intersect(tone_cell,cs_trace_activated_id);
tone_only_real=setdiff(tone_only,rule_out1);
rule_out2=intersect(trace_cell,cs_trace_activated_id);
trace_only_real=setdiff(trace_only,rule_out2);

a=intersect(tone_only,cs_trace_activated_id);
b=intersect(trace_only,cs_trace_activated_id);
tone_activated_id=tone_only;
trace_activated_id=trace_only;
responsive_id=[cs_trace_activated_id;tone_only_real;trace_only_real];
non_responsive_id=setdiff([1:1:366]',responsive_id);


% shock_activated_id= sdff_shock{6}; %  selected cell id
% tone_activated_id= sdff_tone{6}; %  selected celll id 
% trace_activated_id = sdff_trace{6};
% % get shock non-responsive cells
% temp1 = 1 : ms.numNeurons;
% temp1( [shock_activated_id';  shock_inhibited_id']) = [];
% shock_non_id = temp1; clear temp1

% set the color for the cells ROI 
% Modify the script to set the color for the cells as you like.
[c1,~]=colorGradient(RGB('red'),RGB('white'), 64*20); % for S+
[c2,~]=colorGradient(RGB('dark'),RGB('white'), 64*20); % for S-
[c3,~]=colorGradient(RGB('orange'),RGB('white'), 64*20); % for SNR
[c4,~]=colorGradient(RGB('dark gray'),RGB('white'), 64*20); 
roi=ms.SFP; % ROI map library

% get <acceptedPool> if not processed in matlab GUI yet 
if ~exist('acceptedPool', 'var')
    idx = ms.idx_accepted + 1;
    acceptedPool = idx;
    deletePool = ms.idx_deleted + 1;
else
    idx = acceptedPool;
end

% map for activated cells
figure('name', sprintf('Shock Activated Cells %s', figname)); 
hold on
imax=roi(:,:, cs_trace_activated_id); 
for i = 1:size(imax,3)
    tmp1=imax(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    % tmp1( tmp1<0.7*max(tmp1,[],'all')) = 0; % optional: sharpen the ROI
    imax(:,:,i)= tmp1;
end
imax=max(imax,[],3);
img=1-imax;    
axis([0, size(img,2), 0, size(img,1)])
imshow(img,[min(img,[],'all'), max(img,[],'all')], 'Border','tight')
ColorRange = [min(img,[],'all')*1.2, max(img,[],'all')*0.9];
colormap(c1);caxis(  ColorRange)

% map for inhibited cells
figure('name', sprintf('tone activated Cells %s', figname)); 
imax=roi(:,:, tone_activated_id); 
for i = 1:size(imax,3)
    tmp1=imax(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    % tmp1( tmp1<0.7*max(tmp1,[],'all')) = 0; % optional: sharpen the ROI    
    imax(:,:,i)= tmp1;
end
imax=max(imax,[],3);
img=1-imax; 
axis([0, size(img,2), 0, size(img,1)])
imshow(img,[min(img,[],'all'), max(img,[],'all')], 'Border','tight')
ColorRange = [min(img,[],'all')*1.2, max(img,[],'all')*0.9];
colormap(c2);caxis(  ColorRange)

% map for non-responsive cells
figure('name', sprintf('trace activated Cells %s', figname)); 
imax=roi(:,:, trace_activated_id); 
for i = 1:size(imax,3)
    tmp1=imax(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    imax(:,:,i)= tmp1;
end
imax=max(imax,[],3);
img=1-imax;  
axis([0, size(img,2), 0, size(img,1)])
imshow(img,[min(img,[],'all'), max(img,[],'all')], 'Border','tight')
ColorRange = [min(img,[],'all')*1.1, max(img,[],'all')*0.9];
colormap(c3);caxis(  ColorRange)

figure('name', sprintf('Non-responsive cells %s', figname)); 
imax=roi(:,:, non_responsive_id); 
for i = 1:size(imax,3)
    tmp1=imax(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    imax(:,:,i)= tmp1;
end
imax=max(imax,[],3);
img=1-imax;  
axis([0, size(img,2), 0, size(img,1)])
imshow(img,[min(img,[],'all'), max(img,[],'all')], 'Border','tight')
ColorRange = [min(img,[],'all')*1.1, max(img,[],'all')*0.9];
colormap(c4);caxis(  ColorRange)

clear img


% =====================
% overlay two images, s+ and s-
imax1=roi(:,:, cs_trace_activated_id);
imax2=roi(:,:, tone_activated_id); 
imax3=roi(:,:, trace_activated_id); 
for i = 1:size(imax1,3)
    tmp1=imax1(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    imax1(:,:,i)= tmp1;
end
for i = 1:size(imax2,3)
    tmp1=imax2(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    imax2(:,:,i)= tmp1;
end
for i = 1:size(imax3,3)
    tmp1=imax3(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    imax3(:,:,i)= tmp1;
end
clear temp1

A=max(imax1,[],3); % max projection of all roi
B=max(imax2,[],3); % max projection of all roi
C=max(imax3,[],3);

figure('name', sprintf('%s', figname)); 
img=imfuse(1-A,1-B,'falsecolor', 'ColorChannels', [1 2 2]);
%img2=imfuse(img,1-C,'falsecolor', 'ColorChannels', [2 1 2]);
imshow(img,'Border','tight');hold on;


disp('done');

%% conditioning session
figname='example'; % figure name
shock_cell=sdff_shock{6};
tone_cell=sdff_tone{6};
trace_cell=sdff_trace{6};
overlap = intersect(intersect(shock_cell,tone_cell),trace_cell);shock_tone = intersect(shock_cell,tone_cell);shock_trace=intersect(shock_cell,trace_cell);
tmp1=setdiff(shock_cell,shock_tone);cs_trace_activated_id=setdiff(tmp1,shock_trace);
tone_trace=intersect(tone_cell,trace_cell);
tmp2=setdiff(tone_cell,shock_tone);tone_activated_id=setdiff(tmp2,tone_trace);
tmp3=setdiff(trace_cell,shock_trace);trace_activated_id=setdiff(tmp3,tone_trace);

% shock_activated_id= sdff_shock{6}; %  selected cell id
% tone_activated_id= sdff_tone{6}; %  selected celll id 
% trace_activated_id = sdff_trace{6};
% % get shock non-responsive cells
% temp1 = 1 : ms.numNeurons;
% temp1( [shock_activated_id';  shock_inhibited_id']) = [];
% shock_non_id = temp1; clear temp1

% set the color for the cells ROI 
% Modify the script to set the color for the cells as you like.
[c1,~]=colorGradient(RGB('red'),RGB('white'), 64*20); % for S+
[c2,~]=colorGradient(RGB('dark gray'),RGB('white'), 64*20); % for S-
[c3,~]=colorGradient(RGB('blue'),RGB('white'), 64*20); % for SNR

roi=ms.SFP; % ROI map library

% get <acceptedPool> if not processed in matlab GUI yet 
if ~exist('acceptedPool', 'var')
    idx = ms.idx_accepted + 1;
    acceptedPool = idx;
    deletePool = ms.idx_deleted + 1;
else
    idx = acceptedPool;
end

% map for activated cells
figure('name', sprintf('Shock Activated Cells %s', figname)); 
hold on
imax=roi(:,:, cs_trace_activated_id); 
for i = 1:size(imax,3)
    tmp1=imax(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    % tmp1( tmp1<0.7*max(tmp1,[],'all')) = 0; % optional: sharpen the ROI
    imax(:,:,i)= tmp1;
end
imax=max(imax,[],3);
img=1-imax;    
axis([0, size(img,2), 0, size(img,1)])
imshow(img,[min(img,[],'all'), max(img,[],'all')], 'Border','tight')
ColorRange = [min(img,[],'all')*1.2, max(img,[],'all')*0.9];
colormap(c1);caxis(  ColorRange)

% map for inhibited cells
figure('name', sprintf('tone activated Cells %s', figname)); 
imax=roi(:,:, tone_activated_id); 
for i = 1:size(imax,3)
    tmp1=imax(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    % tmp1( tmp1<0.7*max(tmp1,[],'all')) = 0; % optional: sharpen the ROI    
    imax(:,:,i)= tmp1;
end
imax=max(imax,[],3);
img=1-imax; 
axis([0, size(img,2), 0, size(img,1)])
imshow(img,[min(img,[],'all'), max(img,[],'all')], 'Border','tight')
ColorRange = [min(img,[],'all')*1.2, max(img,[],'all')*0.9];
colormap(c2);caxis(  ColorRange)

% map for non-responsive cells
figure('name', sprintf('trace activated Cells %s', figname)); 
imax=roi(:,:, trace_activated_id); 
for i = 1:size(imax,3)
    tmp1=imax(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    imax(:,:,i)= tmp1;
end
imax=max(imax,[],3);
img=1-imax;  
axis([0, size(img,2), 0, size(img,1)])
imshow(img,[min(img,[],'all'), max(img,[],'all')], 'Border','tight')
ColorRange = [min(img,[],'all')*1.1, max(img,[],'all')*0.9];
colormap(c3);caxis(  ColorRange)

clear img


% =====================
% overlay two images, s+ and s-
imax1=roi(:,:, cs_trace_activated_id);
imax2=roi(:,:, tone_activated_id); 
imax3=roi(:,:, trace_activated_id); 
for i = 1:size(imax1,3)
    tmp1=imax1(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    imax1(:,:,i)= tmp1;
end
for i = 1:size(imax2,3)
    tmp1=imax2(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    imax2(:,:,i)= tmp1;
end
for i = 1:size(imax3,3)
    tmp1=imax3(:,:,i);
    tmp1=tmp1./max(tmp1,[],'all');
    imax3(:,:,i)= tmp1;
end
clear temp1

A=max(imax1,[],3); % max projection of all roi
B=max(imax2,[],3); % max projection of all roi
C=max(imax3,[],3);

figure('name', sprintf('%s', figname)); 
img=imfuse(1-A,1-B,'falsecolor', 'ColorChannels', [1 2 2]);
%img2=imfuse(img,1-C,'falsecolor', 'ColorChannels', [2 1 2]);
imshow(img,'Border','tight');hold on;


disp('done');



