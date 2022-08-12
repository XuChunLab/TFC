%% conditioning shock cell plasticity 变化
clc;clear;
filepath= 'D:\miniscope analysis\bt_miniscope\dca1\sigraw\combine2\method5\conditioning5';% conditioning5 data is in the data resource folder
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'cond_sdff_cell.mat'));load(fullfile(filepath,'cond_sdff_data.mat'));
load(fullfile(filepath,'cond_poolTogether.mat'));load(fullfile(filepath,'cond_inhibited.mat'));
load dca1_shock_cell_clustering;

%% plot fear neuron heat map
neuron_id=shock_stable;
for s=1:4
    baseline_mean=nanmean(cond.all_whole_response(:,1:600,s),2); % 1651:1800
    whole_responsez(:,:,s)=(cond.all_whole_response(:,1681:2100,s)-baseline_mean);  
end

whole_responsezmean1=nanmean(whole_responsez(:,:,1),3);

[c1,~]=colorGradient(RGB('red'),RGB('darkred'),64*2); % red to black
[c2,~]=colorGradient(RGB('orange'),RGB('red'),64*0.5); % yellow to red
[c3,~]=colorGradient(RGB('white'), RGB('orange'),64*0.5); % blue to yellow
[c4,~]=colorGradient(RGB('blue'),RGB('white'),64);
[c5,~]=colorGradient(RGB('midnightblue'),RGB('blue'),64*2);
c = [c5;c4;c3;c2;c1];

% shock 1
figure('Position',[300, 100, 350,length(neuron_id)/1]); %length(neuron_id)
[valmax,indmax]=max(whole_responsezmean1(neuron_id,120:300),[],2);
[~,indsort]=sort(indmax); 
plot_tone_id=neuron_id(indsort);
imagesc(whole_responsezmean1(plot_tone_id,1:420));colorbar;
hold on;
colormap(c); 
caxis([-10 10]);
hold on;

xline( 120, '--k','linewidth',0.75);
xline( 300, '--k','linewidth',0.75);
set(gca,'ytick',[]);
set(gca,'xtick',[]);
%
% shock 2 
whole_responsezmean2=nanmean(whole_responsez(:,:,2),3);
% plot habituation heatmap

figure('Position',[300, 100, 350,length(neuron_id)/1]); %length(neuron_id)
imagesc(whole_responsezmean2(plot_tone_id,1:420));%colorbar;
hold on;
colormap(c); 
caxis([-10 10]);
hold on;

xline( 120, '--k','linewidth',0.75);
xline( 300, '--k','linewidth',0.75);
set(gca,'ytick',[]);
set(gca,'xtick',[]);

% shock 3
whole_responsezmean3=nanmean(whole_responsez(:,:,3),3);
% plot habituation heatmap

figure('Position',[300, 100, 350,length(neuron_id)/1]); %length(neuron_id)
imagesc(whole_responsezmean3(plot_tone_id,1:420));%colorbar;
hold on;
colormap(c); 
caxis([-10 10]);
hold on;

xline( 120, '--k','linewidth',0.75);
xline( 300, '--k','linewidth',0.75);
set(gca,'ytick',[]);
set(gca,'xtick',[]);

% shock 4
 whole_responsezmean4=nanmean(whole_responsez(:,:,4),3);
% plot habituation heatmap

figure('Position',[300, 100, 350,length(neuron_id)/1]); %length(neuron_id)
imagesc(whole_responsezmean4(plot_tone_id,1:420));%colorbar;
hold on;
colormap(c); 
caxis([-10 10]);
hold on;

xline( 120, '--k','linewidth',0.75);
xline( 300, '--k','linewidth',0.75);
set(gca,'ytick',[]);
set(gca,'xtick',[]);
 
%% plot calcium trace
% -5s---12s,
neuron_id=shock_stable;
figure('Position',[100, 400, 300,150]);
SR_id_increase=neuron_id;
response_activity=whole_responsezmean1(SR_id_increase,:);
responsez_hist  = zeros(length(SR_id_increase),420);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:480,response_activity(i,1:420),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:420,mean_response_hist,sem_response_hist,{'Color','k','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  
xline( 120, '--r','linewidth',2);
xline( 300, '--r','linewidth',2);
xticks([]); 
hold on; xlim([0,420]);
SetFigure;axis off;
hold on;
%
% retrieval phase
response_activity=whole_responsezmean2(SR_id_increase,:);
responsez_hist  = zeros(length(SR_id_increase),420);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:420,response_activity(i,1:420),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:420,mean_response_hist,sem_response_hist,{'Color','r','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  
xline( 120, '--r','linewidth',2);
xline( 300, '--r','linewidth',2);
hold on;
% ext phase
response_activity=whole_responsezmean3(SR_id_increase,:);
responsez_hist  = zeros(length(SR_id_increase),420);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:420,response_activity(i,1:420),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:420,mean_response_hist,sem_response_hist,{'Color','m','LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  
xline( 120, '--r','linewidth',2);
xline( 300, '--r','linewidth',2);
hold on;
 % last phase
response_activity=whole_responsezmean4(SR_id_increase,:);
responsez_hist  = zeros(length(SR_id_increase),420);
   for i = 1:length(SR_id_increase)
       responsez_hist(i,:) = GaussSmooth(1:510,response_activity(i,1:420),20);
   end
   mean_response_hist = mean(responsez_hist,1);% 关键在于这个地方，而非在高斯平滑那里求平均
   std_response_hist = nanstd(responsez_hist,0,1);
   sem_response_hist = nanstd(responsez_hist,0,1)/sqrt(length(SR_id_increase));
   h = shadedErrorBar(1:420,mean_response_hist,sem_response_hist,{'Color',[0.23 0.70 0.44],'LineStyle','-','linewidth',3},1);hold on;
   set(h.mainLine,'LineWidth',1.5);hold on;  
xline( 120, '--r','linewidth',2);
xline( 300, '--r','linewidth',2);
hold on;
ylim([-1.5,1.0]);
plot([100,100],[0,1],'-k','linewidth',2);
%% signgle mouse 比例
for n=1:7
    shock_up_m{n}=[];
    shock_down_m{n}=[];
    shock_stable_m{n}=[];
end
for n=1:size(shock_up,1)
    if shock_up(n)>0 &shock_up(n)<=289
        shock_up_m{1}=[shock_up_m{1};shock_up(n)];
    else if shock_up(n)>289 &shock_up(n)<=565
            shock_up_m{2}=[shock_up_m{2};shock_up(n)];
            else if shock_up(n)>565 &shock_up(n)<=1024
            shock_up_m{3}=[shock_up_m{3};shock_up(n)];
            else if shock_up(n)>1024 &shock_up(n)<=1091
            shock_up_m{4}=[shock_up_m{4};shock_up(n)];
                        else if shock_up(n)>1091 &shock_up(n)<=1581
            shock_up_m{5}=[shock_up_m{5};shock_up(n)];
            else if shock_up(n)>1581 &shock_up(n)<=2715
            shock_up_m{6}=[shock_up_m{6};shock_up(n)];
                else shock_up(n)>2715 &shock_up(n)<=3081
            shock_up_m{7}=[shock_up_m{7};shock_up(n)];
                    
    end
                            end
                end
                end
        end
    end
end

for n=1:size(shock_down,1)
    if shock_down(n)>0 &shock_down(n)<=289
        shock_down_m{1}=[shock_down_m{1};shock_down(n)];
    else if shock_down(n)>289 &shock_down(n)<=565
            shock_down_m{2}=[shock_down_m{2};shock_down(n)];
            else if shock_down(n)>565 &shock_down(n)<=1024
            shock_down_m{3}=[shock_down_m{3};shock_down(n)];
            else if shock_down(n)>1024 &shock_down(n)<=1091
            shock_down_m{4}=[shock_down_m{4};shock_down(n)];
                        else if shock_down(n)>1091 &shock_down(n)<=1581
            shock_down_m{5}=[shock_down_m{5};shock_down(n)];
            else if shock_down(n)>1581 &shock_down(n)<=2715
            shock_down_m{6}=[shock_down_m{6};shock_down(n)];
                else shock_down(n)>2715 &shock_down(n)<=3081
            shock_down_m{7}=[shock_down_m{7};shock_down(n)];
                    
    end
                            end
                end
                end
        end
    end
end

for n=1:size(shock_stable,1)
    if shock_stable(n)>0 &shock_stable(n)<=289
        shock_stable_m{1}=[shock_stable_m{1};shock_stable(n)];
    else if shock_stable(n)>289 &shock_stable(n)<=565
            shock_stable_m{2}=[shock_stable_m{2};shock_stable(n)];
            else if shock_stable(n)>565 &shock_stable(n)<=1024
            shock_stable_m{3}=[shock_stable_m{3};shock_stable(n)];
            else if shock_stable(n)>1024 &shock_stable(n)<=1091
            shock_stable_m{4}=[shock_stable_m{4};shock_stable(n)];
                        else if shock_stable(n)>1091 &shock_stable(n)<=1581
            shock_stable_m{5}=[shock_stable_m{5};shock_stable(n)];
            else if shock_stable(n)>1581 &shock_stable(n)<=2715
            shock_stable_m{6}=[shock_stable_m{6};shock_stable(n)];
                else shock_stable(n)>2715 & shock_stable(n)<=3081
            shock_stable_m{7}=[shock_stable_m{7};shock_stable(n)];
                    
    end
                            end
                end
                end
        end
    end
end

%% 百分比
% other shock cell

for n=1:7
    step1{n} = union (shock_stable_m{n},shock_up_m{n});
    step2{n} = union (step1{n},shock_down_m{n}); 
    step3{n} = setdiff(shock_final{n},step2{n});
end




for n=1:7
stable(n) = (length(shock_stable_m{n})/size(cond_sdff.baseline_response{n},1))*100;
up(n) = (length(shock_up_m{n})/size(cond_sdff.baseline_response{n},1))*100;
down(n) = (length(shock_down_m{n})/size(cond_sdff.baseline_response{n},1))*100;
inhibited(n) = (length(shockInhibited_ID{n})/size(cond_sdff.baseline_response{n},1))*100;
others(n) = (length(step3{n})/size(cond_sdff.baseline_response{n},1))*100;
end



















