
%% plot cases spontanuos activity
load sig % sig data is in the Figure 2A folder
sig_sdff=sig;
numplot = randperm(size(sig_sdff,1), 11); 
sigt=sig(numplot,:);
sigt=sigt./max(sigt,[],2); % normalize by the peak.
sigt1 = sigt(:, 1147 : 1386);
sigt = sigt(:, 1147 : 1386); % session No.2 is fear conditoning session.
plot((sigt+(1:size(sigt,1))')','color','k','linewidth',1);
hold on;axis off;box off;
%
xline(60,'-r');hold on;
xline(120,'-r');hold on;
xline(180,'-r');hold on;
area([180; 182],[ylim; ylim],'FaceAlpha',0.2,'FaceColor','r','LineStyle','none');axis off
hold on;
plot([1,16],[0.5,0.5],'k','linewidth',2);
box off;

% 可以先生成不带线条隔开的图，然后再生成有线条隔开的图，baseline选择20s，不用选择40s





