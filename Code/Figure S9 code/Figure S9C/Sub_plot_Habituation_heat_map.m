%% plot dca1 habituation session tone activated cell, tone&trace,trace-specific cell heat map
clc;clear;
filepath= 'D:\miniscope analysis\bt_miniscope\sub\sigraw\combine2\method3\habituation3';% habituation3 data is in the data resource folder
filenames=dir([ filepath, '\*.mat']);
nfilenames = numel(filenames); 
for n=1 : nfilenames
    load(fullfile(filepath,filenames(n).name));
end
%% 
tone_trace=intersect(habituation.all_tone_final,habituation.all_trace_final);
tone_specific=setdiff(habituation.all_tone_final,tone_trace);
% temp1=intersect(tone_specific,habituation.all_persistent);
% tone_only=setdiff(tone_specific,temp1);
trace_specific=setdiff(habituation.all_sdff_trace,tone_trace);
% temp2=intersect(trace_specific,habituation.all_persistent);
% trace_only=setdiff(trace_specific,temp2);
tone_responsez=[];trace_responsez=[];whole_responsez=[];
habi_persistent=habituation.habi_all_persistent3;

a=intersect(tone_specific,habi_persistent)

for s=1:3
    baseline_mean=nanmean(habituation.all_baseline_response(:,:,s),2);
    trace_responsez(:,:,s)=(habituation.all_trace_response(:,:,s)-baseline_mean);  
    tone_responsez(:,:,s)=(habituation.all_tone_response(:,:,s)-baseline_mean);
    whole_responsez(:,:,s)=(habituation.all_whole_response(:,:,s)-baseline_mean);  
end

trace_responsezmean=nanmean(trace_responsez,3);
tone_responsezmean=nanmean(tone_responsez,3);
whole_responsezmean=nanmean(whole_responsez,3);
tone_only=tone_specific;
trace_only=trace_specific;
%%
xline1 = 20*30; % tone ON
xline2 = 20*30 + 30 * 30; % 20 sec * 30 Hz % trace ON
xline3 = 20*30 + 50*30; % 40 sec * 30Hz % trace OFF
% plot raw heat map
% tempnumplot1 = randperm(size(tone_specific,1), 10); 
% numtone = tone_specific(tempnumplot1);
% tempnumplot2 = randperm(size(trace_specific,1),10); 
% numtrace = trace_specific(tempnumplot2);
clear valmax;clear indmax;clear indsort;
figure('Position',[300, 100, 350,65]);
[valmax,indmax]=max(tone_responsezmean(tone_only,:),[],2);
% indmax is represent the frame ID for max response.
% sort the cell order by the earlist frame ID with max response.
[~,indsort]=sort(indmax); 
plot_tone_id=tone_only(indsort);
imagesc(whole_responsezmean(plot_tone_id,:),[1.65,6]);%colorbar
hold on;
%colorbar;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( xline1, '-r','linewidth',2); xline(xline2,'-r','linewidth',2);xline(xline3,'-r','linewidth',2); xticks([]);
%xlabel('Time ');
%title('Tone-only');
%%
clear valmax;clear indmax;clear indsort;
figure('Position',[300, 100, 350,68]);
[valmax,indmax]=max(tone_responsezmean(habi_persistent,:),[],2);
% indmax is represent the frame ID for max response.
% sort the cell order by the earlist frame ID with max response.
[~,indsort]=sort(indmax); 
plot_persistent_id=habi_persistent(indsort);
imagesc(whole_responsezmean(plot_persistent_id,:),[1.65,6]);
hold on;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( xline1, '-r','linewidth',2); xline(xline2,'-r','linewidth',2);xline(xline3,'-r','linewidth',2); xticks([]);    
%title('Tone-trace');
%%
clear valmax;clear indmax;clear indsort;
figure('Position',[300, 100, 350,142]);
[valmax,indmax]=max(trace_responsezmean(trace_only,:),[],2);
% indmax is represent the frame ID for max response.
% sort the cell order by the earlist frame ID with max response.
[~,indsort]=sort(indmax); 
plot_trace_id=trace_only(indsort);
imagesc(whole_responsezmean(plot_trace_id,:),[1.65,6]);
hold on;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( xline1, '-r','linewidth',2); xline(xline2,'-r','linewidth',2);xline(xline3,'-r','linewidth',2); xticks([]); 

%% plot all
figure('Position',[300, 100, 400,500]);
all_id=[plot_tone_id;plot_persistent_id;plot_trace_id];
imagesc(whole_responsezmean(all_id,:),[1.65,6]);
hold on;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( xline1, '-r','linewidth',2); xline(xline2,'-r','linewidth',2);xline(xline3,'-r','linewidth',2); xticks([]); 


%% test 
xline1 = 10*30; % tone ON
xline2 = 10*30 + 30 * 30; % 20 sec * 30 Hz % trace ON
xline3 = 10*30 + 50*30; % 40 sec * 30Hz % trace OFF
tmp1=[6:20,24:30,88,89,98,35,43,44,75,78:82,105,106,118,125:127,23:26,220:236];
numtone=tone_specific(tmp1); % 此为作图时用的tone-specific的case
tmp2=[4:5,7:21,25,27:31,163,164,172:181,184,275,277,280,281,283,284,286,288,292,294,295,296,297,300,303,304,307,310,311,317,318,319,321,323,326,327,334,335,424,426,427,430,432,433,436];
numoverlap=tone_trace(tmp2);
tmp3=[390:391,406:411,419:422,426,429:434,250:265,268:271,275:278,281:283,285:292,295:299,337,345,344,361,370,374:377,32,33,35,37:40,43];
numtrace=trace_specific(tmp3);

subplot(1,3,1);
imagesc(whole_responsezmean(numtone,301:2400),[1.65,6]);
hold on;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( xline1, '-r','linewidth',2); xline(xline2,'-r','linewidth',2);xline(xline3,'-r','linewidth',2);    
xticks([]);
xlabel('Time ');
title('tone Mean Response');

subplot(1,3,2);
imagesc(whole_responsezmean(numoverlap,301:2400),[1.65,6]);
hold on;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( xline1, '-r','linewidth',2); xline(xline2,'-r','linewidth',2);xline(xline3,'-r','linewidth',2);    xticks([]);
xlabel('Time ');
title('overlap Mean Response');

subplot(1,3,3);
imagesc(whole_responsezmean(numtrace,301:2400),[1.65,6]);
hold on;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( xline1, '-r','linewidth',2); xline(xline2,'-r','linewidth',2);xline(xline3,'-r','linewidth',2);    
 
xticks([]);
xlabel('Time ');
title('trace Mean Response');
SetFigure;

%% 合起来画图
together=[numtone;numoverlap;numtrace];
% together=[numtone;numtrace;numoverlap];
imagesc(whole_responsezmean(together,301:2400),[1.65,6]);
hold on;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( xline1, '-r','linewidth',2); xline(xline2,'-r','linewidth',2);xline(xline3,'-r','linewidth',2);    
xticks([]);
colorbar
%SetFigure;











