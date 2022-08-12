%% fear neuron 3个session对齐来进行分析
clc;clear;
filepath= 'D:\miniscope analysis\bt_miniscope\sub\sigraw\combine2\method3\habituation3';
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'habituation_sdff_cell.mat'));load(fullfile(filepath,'habituation_sdff_data.mat'));
load(fullfile(filepath,'habituation_poolTogether.mat'));

filepath= 'D:\miniscope analysis\bt_miniscope\sub\sigraw\combine2\method3\feartest3';
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'fearTest_sdff_cell.mat'));load(fullfile(filepath,'fearTest_data.mat'));
load(fullfile(filepath,'fearTest_poolTogether.mat'));load(fullfile(filepath,'fearTest_inhibited.mat'));

filepath= 'D:\miniscope analysis\bt_miniscope\sub\sigraw\combine2\method3\laterextinct3';
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'laterExtinct_sdff_cell.mat'));load(fullfile(filepath,'laterExtinct_data.mat'));
load(fullfile(filepath,'laterExtinct_poolTogether.mat'));%load(fullfile(filepath,'laterextinct_inhibited.mat'));
%% find fear neuron all cell pool together

stable_activated=intersect(habituation.all_tone_final,fearTest.all_sdff_tone); % control 第一类cell，responsive stable
from_0_1=setdiff(fearTest.all_sdff_tone,stable_activated); %从无到有反应，无的状态里包含了-1和0 第二类
% 第1类 fear neuron
temp1=intersect(fearTest.all_sdff_tone,laterExtinct.all_sdff_tone);
temp2=setdiff(fearTest.all_sdff_tone,temp1);
fear_neuron=intersect(from_0_1,temp2);
% common group
s1_s2_overlap=intersect(habituation.all_sdff_tone,fearTest.all_sdff_tone);
s1_s3_overlap=intersect(habituation.all_sdff_tone,laterExtinct.all_sdff_tone);
s2_s3_overlap=intersect(fearTest.all_sdff_tone,laterExtinct.all_sdff_tone);
% type 2 fear inhibited neuron
tmp1=setdiff(habituation.all_sdff_tone,s1_s2_overlap);
fear_inh=intersect(tmp1,laterExtinct.all_sdff_tone);
% type3 persistent
persistent_cell=intersect(s1_s2_overlap,laterExtinct.all_sdff_tone);
% type 4 ext resist
tmp2=setdiff(fearTest.all_sdff_tone,s1_s2_overlap);
ext_resist=intersect(tmp2,laterExtinct.all_sdff_tone);
% type 5 ext up
tmp3=setdiff(laterExtinct.all_sdff_tone,s2_s3_overlap);
tmp4=intersect(tmp3,habituation.all_sdff_tone);
ext_up=setdiff(tmp3,tmp4);
% type 6 novel
tmp5=setdiff(habituation.all_sdff_tone,s1_s2_overlap);
tmp6=intersect(tmp5,laterExtinct.all_sdff_tone);
novel=setdiff(tmp5,tmp6);


%% 指定neuron ID
number=1;
neuron_id=ext_up;
%% plot habituation session heat map
for s=1:3
    baseline_mean=nanmean(habituation.all_baseline_response(:,:,s),2);
    trace_responsez(:,:,s)=(habituation.all_trace_response(:,:,s)-baseline_mean);  
    tone_responsez(:,:,s)=(habituation.all_tone_response(:,:,s)-baseline_mean);
    whole_responsez(:,:,s)=(habituation.all_whole_response(:,:,s)-baseline_mean);  
end

trace_responsezmean=nanmean(trace_responsez,3);
tone_responsezmean=nanmean(tone_responsez,3);
whole_responsezmean=nanmean(whole_responsez,3);
% plot habituation heatmap
% fear_neuron,fear_inh,persistent_cell,ext_resist,ext_up,novel,

[c1,~]=colorGradient(RGB('red'),RGB('darkred'),64*2); % red to black
[c2,~]=colorGradient(RGB('orange'),RGB('red'),64*0.5); % yellow to red
[c3,~]=colorGradient(RGB('white'), RGB('orange'),64*0.5); % blue to yellow
[c4,~]=colorGradient(RGB('blue'),RGB('white'),64);
[c5,~]=colorGradient(RGB('midnightblue'),RGB('blue'),64*2);
c = [c5;c4;c3;c2;c1];

figure('Position',[300, 100, 350,length(neuron_id)/number]); %length(neuron_id)
 [valmax,indmax]=max(tone_responsezmean(neuron_id,:),[],2);
 [~,indsort]=sort(indmax); 
 plot_tone_id=neuron_id(indsort);
imagesc(whole_responsezmean(plot_tone_id,300:1800));%colorbar;
hold on;
colormap(c); 
caxis([-10 10]);
colorbar;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( 300, '--k','linewidth',0.75); xline(1200,'--k','linewidth',0.75);%xline(xline3,'-r','linewidth',2); xticks([]);
% axis off;
set(gca,'ytick',[]);
set(gca,'xtick',[]);
 %% plot retri heat map
 % stable_activated,from_0_1,from_1_0,stable_inhibited,from_inhibit_to_0,from_0_to_inhibit
for s=1:3
    baseline_mean2=nanmean(fearTest.all_baseline_response(:,:,s),2);
    trace_responsez2(:,:,s)=(fearTest.all_trace_response(:,:,s)-baseline_mean2);  
    tone_responsez2(:,:,s)=(fearTest.all_tone_response(:,:,s)-baseline_mean2);
    whole_responsez2(:,:,s)=(fearTest.all_whole_response(:,:,s)-baseline_mean2);  
end

trace_responsezmean2=nanmean(trace_responsez2(:,:,1:3),3);
tone_responsezmean2=nanmean(tone_responsez2(:,:,1:3),3);
whole_responsezmean2=nanmean(whole_responsez2(:,:,1:3),3);

%neuron_id=stable_activated;
figure('Position',[300, 100, 350,length(neuron_id)/number]); %length(neuron_id)
% [valmax,indmax]=max(tone_responsezmean2(neuron_id,:),[],2);
% [~,indsort]=sort(indmax); 
% plot_tone_id=neuron_id(indsort);
imagesc(whole_responsezmean2(plot_tone_id,300:1800)); %imagesc(whole_responsezmean3(plot_tone_id,300:1800),[2,6]);
hold on;
colormap(c); 
caxis([-10 10]);
%colorbar;
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( 300, '--k','linewidth',0.75); xline(1200,'--k','linewidth',0.75);%xline(xline3,'-r','linewidth',2); xticks([]);
set(gca,'ytick',[]);
set(gca,'xtick',[]);
%% plot ext session heat map
 
 for s=7:9
    baseline_mean3=nanmean(laterExtinct.all_baseline_response(:,:,s),2);
    trace_responsez3(:,:,s)=(laterExtinct.all_trace_response(:,:,s)-baseline_mean3);  
    tone_responsez3(:,:,s)=(laterExtinct.all_tone_response(:,:,s)-baseline_mean3);
    whole_responsez3(:,:,s)=(laterExtinct.all_whole_response(:,:,s)-baseline_mean3);  
end

trace_responsezmean3=nanmean(trace_responsez3(:,:,7:9),3);
tone_responsezmean3=nanmean(tone_responsez3(:,:,7:9),3);
whole_responsezmean3=nanmean(whole_responsez3(:,:,7:9),3);

%neuron_id=stable_activated;
figure('Position',[300, 100, 350,length(neuron_id)/number]); %length(neuron_id)

[valmax,indmax]=max(tone_responsezmean3(neuron_id,:),[],2);
[~,indsort]=sort(indmax); 
plot_tone_id=neuron_id(indsort);

imagesc(whole_responsezmean3(plot_tone_id,300:1800));
hold on;
colormap(c); 
caxis([-10 10]);
%area([xline3; xline3+shock_dur],[ylim; ylim],'FaceAlpha',0.4,'FaceColor','r','LineStyle','none')
xline( 300, '--k','linewidth',0.75); xline(1200,'--k','linewidth',0.75);%xline(xline3,'-r','linewidth',2); xticks([]);
set(gca,'ytick',[]);
set(gca,'xtick',[]);
 
%% plot calcium trace
% baseline_responsemean= nanmean(cond.all_baseline_response(:,:,4),3);
% whole_responsemean=nanmean(cond.all_whole_response(:,:,4),3);
% fear_neuron,fear_inh,persistent_cell,ext_resist,ext_up,novel,
figure('Position',[100, 400, 300,150]);
SR_id_increase = novel;
response_activity=whole_responsezmean(SR_id_increase,300:1800);
responsez_hist  = zeros(length(SR_id_increase),1500);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:1500,response_activity(i,1:1500),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:1500,mean_response_hist,sem_response_hist,{'Color','k','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  

xticks([]); 
hold on; xlim([0,1500]);
SetFigure;axis off;
hold on;
%
% retrieval phase
response_activity=whole_responsezmean2(SR_id_increase,300:1800);
responsez_hist  = zeros(length(SR_id_increase),1500);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:1500,response_activity(i,1:1500),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:1500,mean_response_hist,sem_response_hist,{'Color','r','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  
xline( 300, '--r','linewidth',2); xline(1200,'--r','linewidth',2);%xline(xline3,'-r','linewidth',2); xticks([]);
hold on;
% ext phase
response_activity=whole_responsezmean3(SR_id_increase,300:1800);
responsez_hist  = zeros(length(SR_id_increase),1500);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:1500,response_activity(i,1:1500),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:1500,mean_response_hist,sem_response_hist,{'Color','m','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  
xline( 300, '--r','linewidth',2); xline(1200,'--r','linewidth',2);%xline(xline3,'-r','linewidth',2); xticks([]);
hold on;
plot([100,100],[0,2],'-k','linewidth',2);
%% find fear neuron in single mouse
clc;clear;
filepath= 'D:\miniscope analysis\bt_miniscope\sub\sigraw\combine2\method3\habituation3';
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'habituation_sdff_cell.mat'));load(fullfile(filepath,'habituation_sdff_data.mat'));
load(fullfile(filepath,'habituation_poolTogether.mat'));
habi_tone_final=tone_final;
filepath= 'D:\miniscope analysis\bt_miniscope\sub\sigraw\combine2\method3\feartest3';
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'fearTest_sdff_cell.mat'));load(fullfile(filepath,'fearTest_data.mat'));
load(fullfile(filepath,'fearTest_poolTogether.mat'));load(fullfile(filepath,'fearTest_inhibited.mat'));
feartest_tone_final=tone_final;
filepath= 'D:\miniscope analysis\bt_miniscope\sub\sigraw\combine2\method3\laterextinct3';
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'laterExtinct_sdff_cell.mat'));load(fullfile(filepath,'laterExtinct_data.mat'));
load(fullfile(filepath,'laterExtinct_poolTogether.mat'));%load(fullfile(filepath,'laterextinct_inhibited.mat'));
laterextinct_tone_final=tone_final;
% 按单只老鼠计算
for n= 1:9
stable_activated_p{n}=intersect(habi_tone_final{n},feartest_tone_final{n}); % control 第一类cell，responsive stable
from_0_1_p{n}=setdiff(feartest_tone_final{n},stable_activated_p{n}); %从无到有反应，无的状态里包含了-1和0 第二类
% 第7类 fear neuron
temp1=intersect(feartest_tone_final{n},laterextinct_tone_final{n});
temp2=setdiff(feartest_tone_final{n},temp1);
fear_neuron_p{n}=intersect(from_0_1_p{n},temp2);
end
%%
% common group
for n=1:9
s1_s2_overlap{n}=intersect(habi_tone_final{n},feartest_tone_final{n});
s1_s3_overlap{n}=intersect(habi_tone_final{n},laterextinct_tone_final{n});
s2_s3_overlap{n}=intersect(feartest_tone_final{n},laterextinct_tone_final{n});
% type 2 fear inhibited neuron
tmp1=setdiff(habi_tone_final{n},s1_s2_overlap{n});
fear_inh{n}=intersect(tmp1,laterextinct_tone_final{n});
% type3 persistent
persistent_cell{n}=intersect(s1_s2_overlap{n},laterextinct_tone_final{n});
% type 4 ext resist
tmp2=setdiff(feartest_tone_final{n},s1_s2_overlap{n});
ext_resist{n}=intersect(tmp2,laterextinct_tone_final{n});
% type 5 ext up
tmp3=setdiff(laterextinct_tone_final{n},s2_s3_overlap{n});
tmp4=intersect(tmp3,habi_tone_final{n});
ext_up{n}=setdiff(tmp3,tmp4);
% type 6 novel
tmp5=setdiff(habi_tone_final{n},s1_s2_overlap{n});
tmp6=intersect(tmp5,laterextinct_tone_final{n});
novel{n}=setdiff(tmp5,tmp6);
end

%%
for n=1:9
fear_neuron_ratio(n) = (length(fear_neuron_p{n})/size(fearTest_sdff.baseline_response{n},1))*100;
fear_inh_p(n) = (length(fear_inh{n})/size(fearTest_sdff.baseline_response{n},1))*100;
persistent_cell_p(n) = (length(persistent_cell{n})/size(fearTest_sdff.baseline_response{n},1))*100;
ext_resist_p(n) = (length(ext_resist{n})/size(fearTest_sdff.baseline_response{n},1))*100;
ext_up_p(n) = (length(ext_up{n})/size(fearTest_sdff.baseline_response{n},1))*100;
novel_p(n) = (length(novel{n})/size(fearTest_sdff.baseline_response{n},1))*100;
end

%% stable vs plastic
for n=1:9
    plastic_neuron(n)=((length(fear_inh{n})+length(fear_neuron_p{n})+length(ext_resist{n})+...
        length(ext_up{n})+length(novel{n}))/size(fearTest_sdff.baseline_response{n},1))*100;
end





