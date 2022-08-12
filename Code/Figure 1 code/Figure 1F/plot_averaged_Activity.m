%% plot persistent cell neural activity in conditioning
clc;clear;
filepath= 'C:\Users\Administrator\OneDrive\桌面\Source Data\code\Figure 1 code\Figure 1E';
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'habituation_sdff_cell.mat'));load(fullfile(filepath,'habituation_sdff_data.mat'));load(fullfile(filepath,'habituation_poolTogether.mat'));

%% trial1
tone_trace=intersect(habituation.all_sdff_tone,habituation.all_sdff_trace);
tone_specific=setdiff(habituation.all_sdff_tone,tone_trace);

trace_specific=setdiff(habituation.all_sdff_trace,tone_trace);

baseline_tmp=nanmean(nanmean(habituation.all_baseline_response(trace_specific,:,:),3),2);
tone_tmp=nanmean(nanmean(habituation.all_tone_response(trace_specific,:,:),3),2);
idtemp=find(tone_tmp-baseline_tmp>3);
trace_specific(idtemp)=[];
tone_responsez=[];trace_responsez=[];whole_responsez=[];
habi_persistent=habituation.habi_all_persistent3;
a = intersect(tone_specific,habi_persistent);

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
pre_dur=20*30;
xline1 = pre_dur; % tone ON
xline2 = pre_dur + 30 * 30; % 20 sec * 30 Hz % trace ON
xline3 = pre_dur + 50*30; % 40 sec * 30Hz % trace OFF
xline4= 50*30;

baseline_responsemean= nanmean(habituation.all_baseline_response(:,:,:),3);
whole_responsemean=nanmean(habituation.all_whole_response(:,:,:),3);

figure('Position',[100, 400, 350,300]);
%SR_id_increase=habituation.all_tone_only;
SR_id_increase=tone_only;
tmp1 = nanmean(baseline_responsemean(SR_id_increase,:), 2); % compute the baseline mean
whole_responsezmean=(whole_responsemean(SR_id_increase,:) - tmp1);
%plot(nanmean( whole_responsemean(SR_id_increase,:) - tmp1,1)); clear tmp1; % subtract the mean, then average
responsez_hist  = zeros(length(SR_id_increase),2700);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:2700,whole_responsezmean(i,1:2700),10);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:2700,mean_response_hist,sem_response_hist,{'Color','k','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  
%plot([1500,1500],[-2,5],'-k');
SR_id_increase=habituation.habi_all_persistent3;
tmp1 = nanmean(baseline_responsemean(SR_id_increase,:), 2); % compute the baseline mean
whole_responsezmean=(whole_responsemean(SR_id_increase,:) - tmp1);
%plot(nanmean( whole_responsemean(SR_id_increase,:) - tmp1,1)); clear tmp1; % subtract the mean, then average
responsez_hist  = zeros(length(SR_id_increase),2700);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:2700,whole_responsezmean(i,1:2700),10);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:2700,mean_response_hist,sem_response_hist,{'Color','r','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  

%SR_id_increase=habituation.all_trace_only;
SR_id_increase=trace_only;
tmp1 = nanmean(baseline_responsemean(SR_id_increase,:), 2); % compute the baseline mean
whole_responsezmean=(whole_responsemean(SR_id_increase,:) - tmp1);
%plot(nanmean( whole_responsemean(SR_id_increase,:) - tmp1,1)); clear tmp1; % subtract the mean, then average
responsez_hist  = zeros(length(SR_id_increase),2700);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:2700,whole_responsezmean(i,1:2700),10);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:2700,mean_response_hist,sem_response_hist,{'Color',[1 0.64 0],'LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  


xticks([]); %ylim([-2.0,6]);
%set(gca,'YTick',[0:2:4]);
% text(320,-1.35,'Tone','FontSize',14);
% text(910,-1.35,'Trace','FontSize',14);
%ylabel('\DeltaF/F(%)','Fontsize',8,'Fontname','Arial');
hold on; xlim([0,2400]);ylim([-1,8]);
SetFigure;
set(gca,'linewidth',1);
set(gca,'fontsize',20);
xline( xline1, '--','color',[0.18 0.3 0.3],'linewidth',1.5); xline(xline2,'--','color',[0.18 0.3 0.3],'linewidth',1.5);
xline(xline3,'--','color',[0.18 0.3 0.3],'linewidth',1.5);  %xline(xline4,'-k','linewidth',1); 
% set(gca,'color',[200/255 216/255 238/255]);
% set(gcf,'color',[200/255 216/255 238/255]);
% print -dpdf -r600 blockcorrect3
%% plot 单只老鼠情况 single mouse plot
pre_dur=20*30;
xline1 = pre_dur; % tone ON
xline2 = pre_dur + 30 * 30; % 20 sec * 30 Hz % trace ON
xline3 = pre_dur + 50*30; % 40 sec * 30Hz % trace OFF
xline4= 50*30;
n=2;
baseline_responsemean= nanmean(habituation_sdff.baseline_response{n}(:,:,:),3);
whole_responsemean=nanmean(habituation_sdff.whole_response{n}(:,:,:),3);

figure('Position',[100, 400, 350,300]);
%SR_id_increase=habituation.all_tone_only;

tone_trace=intersect(tone_final{n},trace_final{n});
tone_only2=setdiff(tone_final{n},tone_trace);
trace_only2=setdiff(trace_final{n},tone_trace);
SR_id_increase=tone_only2;
tmp1 = nanmean(baseline_responsemean(SR_id_increase,:), 2); % compute the baseline mean
whole_responsezmean=(whole_responsemean(SR_id_increase,:) - tmp1);
%plot(nanmean( whole_responsemean(SR_id_increase,:) - tmp1,1)); clear tmp1; % subtract the mean, then average
responsez_hist  = zeros(length(SR_id_increase),2700);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:2700,whole_responsezmean(i,1:2700),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:2700,mean_response_hist,sem_response_hist,{'Color','k','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  
%plot([1500,1500],[-2,5],'-k');
SR_id_increase=habi_persistent3{n};
tmp1 = nanmean(baseline_responsemean(SR_id_increase,:), 2); % compute the baseline mean
whole_responsezmean=(whole_responsemean(SR_id_increase,:) - tmp1);
%plot(nanmean( whole_responsemean(SR_id_increase,:) - tmp1,1)); clear tmp1; % subtract the mean, then average
responsez_hist  = zeros(length(SR_id_increase),2700);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:2700,whole_responsezmean(i,1:2700),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:2700,mean_response_hist,sem_response_hist,{'Color','r','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  

%SR_id_increase=habituation.all_trace_only;
SR_id_increase=trace_only2;
tmp1 = nanmean(baseline_responsemean(SR_id_increase,:), 2); % compute the baseline mean
whole_responsezmean=(whole_responsemean(SR_id_increase,:) - tmp1);
%plot(nanmean( whole_responsemean(SR_id_increase,:) - tmp1,1)); clear tmp1; % subtract the mean, then average
responsez_hist  = zeros(length(SR_id_increase),2700);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:2700,whole_responsezmean(i,1:2700),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:2700,mean_response_hist,sem_response_hist,{'Color',[1 0.64 0],'LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  


xticks([]); %ylim([-2.0,6]);
%set(gca,'YTick',[0:2:4]);
% text(320,-1.35,'Tone','FontSize',14);
% text(910,-1.35,'Trace','FontSize',14);
%ylabel('\DeltaF/F(%)','Fontsize',8,'Fontname','Arial');
hold on; xlim([0,2400]);ylim([-1,14]);
SetFigure;
set(gca,'linewidth',1);
set(gca,'fontsize',20);
xline( xline1, '--','color',[0.18 0.3 0.3],'linewidth',1.5); xline(xline2,'--','color',[0.18 0.3 0.3],'linewidth',1.5);
xline(xline3,'--','color',[0.18 0.3 0.3],'linewidth',1.5);  %xline(xline4,'-k','linewidth',1); 
% set(gca,'color',[200/255 216/255 238/255]);
% set(gcf,'color',[200/255 216/255 238/255]);
% print -dpdf -r600 blockcorrect3














