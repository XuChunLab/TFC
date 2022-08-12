%% plot single neuron example (averaged from 4 trials in conditioning) figure 2 中的 b图
clc;clear;
load sig;
Cond_tone_ts = [240, 260; 402, 422; 564, 584; 726, 746];
Cond_trace_ts = [260, 280; 422, 442; 584, 604; 746, 766];
Cond_shock_ts = [280, 282; 442, 444; 604, 606; 766, 768]; 
% 即新产生的每个数据点是333ms,
figure;
%tempnumplot = randperm(size(cond.all_tone_final,1), 5); 
%numplot = cond.all_tone_final(tempnumplot);
numplot=[2647,1144,1582,2644,2167];

sigt=sig(numplot,660:end);
sigt=sigt./max(sigt,[],2);
plot((sigt+(1:size(sigt,1))')');
hold on;axis off;box off;
xline1=720-660;xline2=780-660;xline22=840-660;xline3=1206-660;xline4=1266-660;xline44=1326-660;
xline5=1692-660;xline6=1752-660;xline66=1812-660;xline7=2178-660;xline8=2238-660;xline88=2298-660;
marker=[xline1,xline2,xline22,xline3,xline4,xline44,xline5,xline6,xline66,xline7,xline8,xline88];
% for i=1:12
% xline( marker(i)+10, '--r');
% hold on;
% end

area([xline1; xline2],[ylim; ylim],'FaceAlpha',0.2,'FaceColor','r','LineStyle','none');
area([xline2; xline22],[ylim; ylim],'FaceAlpha',0.3,'FaceColor',[0 0.74 1],'LineStyle','none');
area([xline3; xline4],[ylim; ylim],'FaceAlpha',0.2,'FaceColor','r','LineStyle','none');
area([xline4; xline44],[ylim; ylim],'FaceAlpha',0.3,'FaceColor',[0 0.74 1],'LineStyle','none');
area([xline5; xline6],[ylim; ylim],'FaceAlpha',0.2,'FaceColor','r','LineStyle','none');
area([xline6; xline66],[ylim; ylim],'FaceAlpha',0.3,'FaceColor',[0 0.74 1],'LineStyle','none');
area([xline7; xline8],[ylim; ylim],'FaceAlpha',0.2,'FaceColor','r','LineStyle','none');
area([xline8; xline88],[ylim; ylim],'FaceAlpha',0.3,'FaceColor',[0 0.74 1],'LineStyle','none');

axis off;box off;

%% 
figure('Position',[500, 500, 300,200]);
b3=b1(1176:1344,:);
plot(b3,'LineWidth',1,'color','k');
xline(30,'--r','LineWidth',1.5);xline(90,'--r','LineWidth',1.5);xline(150,'--r','LineWidth',1.5);
box off;
axis off;ylim([0.8,1.8]);






