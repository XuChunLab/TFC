%% plot single neuron example (averaged from 4 trials in conditioning) figure 2 中的 b图
clc;clear;
load sig;
%% plot candidate neuron single trial
% 以前是300点代表10s，现在是变成了3hz的采样率，那就是30个点是10s；
Cond_tone_ts = [240, 260; 402, 422; 564, 584; 726, 746];
Cond_trace_ts = [260, 280; 422, 442; 584, 604; 746, 766];
Cond_shock_ts = [280, 282; 442, 444; 604, 606; 766, 768]; 

numplot1 = 1122; % example neuron
sigt=sig(numplot1,:);
sigt=sigt./max(sigt,[],2); % normalize by the peak.
%
b1=(sigt+(1:size(sigt,1))')'
figure('Position',[500, 500, 300,200]);
b3=b1(690:870,:); % trial 1 is 690:870, trial 2 is 1176:1356, trial 3 is 1662:1842, trial 4 is 2148:2328
plot(b3,'LineWidth',1,'color','k');
xline(30,'--r','LineWidth',1.5);xline(90,'--r','LineWidth',1.5);xline(150,'--r','LineWidth',1.5);
box off;
axis off;ylim([0.8,1.8]);








