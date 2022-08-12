clc;clear;
load sub_habi_activity;
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













