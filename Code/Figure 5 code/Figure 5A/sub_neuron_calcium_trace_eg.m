load sub_sig;
figure;
%sig=sig_sdff;
tempnumplot = randperm(size(cond.all_sdff_trace,1), 5); 
%numplot = cond.all_sdff_trace(tempnumplot);

numplot = [283 232	334  398 129] % example neuron id

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




