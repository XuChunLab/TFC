%% import data
clc;clear;
filepath = 'D:\miniscope analysis\bt_miniscope\dca1\processed';
filenames=dir([ filepath, '\processed_*.mat']);
savepath = 'D:\miniscope analysis\bt_miniscope\dca1\processed';
file1 = fullfile( savepath, 'TFCbatch.mat'); % save results of batch processes

animaldata=cell(numel(filenames),1);
nfilenames = numel(filenames); 
for n=1 : nfilenames
    animaldata{n}=load(fullfile(filepath,filenames(n).name));
end
%% draw sigraw habituation data 
Cond_tone_ts = [240, 270; 360, 390; 480, 510];
Cond_trace_ts = [270, 290; 390, 410; 510, 530];

habituation_protocol.tone_ts=Cond_tone_ts;
habituation_protocol.trace_ts=Cond_trace_ts;

sigraw=cell(numel(filenames),1);
% common parameters
pre_dur=20 * 30; % frame: sec * original sample rate 30 Hz
post_dur=20 * 30;% frame: sec * original sample rate 30 Hz
shock_dur = 6 * 30; % frame: sec * original sample rate 30 Hz
%shock_dur = 2 * 30; % frame: sec * original sample rate 30 Hz
binsize=20; % frame number
p_threshold=0.05;
b_useZscore = false; % false; % true;
zscorethreshold=2.56;
colormax = 20; % for imagesc

% find the biggest size of TFC session
session_dur = NaN(1, nfilenames);
cell_num = NaN(1, nfilenames);
for n = 1 : nfilenames
    session_start = animaldata{n}.session_start(1);
    session_end = animaldata{n}.session_end(1);
    session_dur( n) = session_end - session_start + 1;    
    cell_num( n) = numel( animaldata{n}.acceptedPool);
end
session_dur_max = max( session_dur, [], 'all');
cell_num_total = sum( cell_num);

animaldata{4}.ms.S_dff=animaldata{4}.ms.sigdeconvolved(:,animaldata{4}.acceptedPool)';
animaldata{5}.ms.S_dff=animaldata{5}.ms.sigdeconvolved(:,animaldata{5}.acceptedPool)';

% collect the data from all animals
cond_sig_all = NaN( cell_num_total, session_dur_max);  %  group data for TFC cond.
cell_total_count = 0;
for n = 1 : nfilenames 
    ms = animaldata{n}.ms;
    sig=ms.sigraw';    
    session_start = animaldata{n}.session_start;
    session_end = animaldata{n}.session_end;
    cell_total_count = cell_total_count + cell_num( n);
    % collect all <sig> from each animal
    sigraw{n}=sig(:,session_start(1):session_end(1));
    cond_sig_all( cell_total_count - cell_num(n) + 1 : cell_total_count, ...
        1 : session_dur( n)) ...
        =sig(:,session_start(1):session_end(1)); %找出conditioning阶段中的所有neuron的反应
end
idxToneON=[];idxToneOFF=[];idxTraceON=[];idxTraceOFF=[];
ms_ts = animaldata{4}. ms_ts;  % we assume condition session from each animal has similar 
for s=1: size( Cond_tone_ts,1)
    idxToneON(s) =  find( ms_ts{1}>=Cond_tone_ts(s,1)*1000, 1, 'first'); %找出conditioning阶段的每个trial中event的时间点信息对应的帧数
    idxToneOFF(s) =  find( ms_ts{1}>=Cond_tone_ts(s,2)*1000, 1, 'first'); 
    idxTraceON(s) =  find( ms_ts{1}>=Cond_trace_ts(s,1)*1000, 1, 'first'); 
    idxTraceOFF(s) =  find( ms_ts{1}>=Cond_trace_ts(s,2)*1000, 1, 'first');       
    
end

cdn_sig=cond_sig_all;
sigraw_afterFT=sigraw;
%% 将10帧数据变成一个数据点，即新产生的每个数据点是333ms
frame = floor(size(cond_sig_all,2)/10);
sig_sdff=[];
for n=1:frame
    sig_sdff(:,n)=nanmean(cond_sig_all(:,10*(n-1)+1:10*n),2);
end

%% get cell type ID

filepath= 'D:\miniscope analysis\bt_miniscope\dca1\sigraw\combine2\method5\habituation5';
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'habituation_sdff_cell.mat'));load(fullfile(filepath,'habituation_sdff_data.mat'));load(fullfile(filepath,'habituation_poolTogether.mat'));

%% plot cases spontanuos activity
figure;
sig=cond_sig_all;
numplot = randperm(size(sig_sdff,1), 11); 
% numplot = all_trace_persistent(tempnumplot);
%numplot = randperm(cell_num_total,11);
% numplot = [2587 2346 1639 2798 2247 2653 2457 3619 148]; % tone-specific
% numplot = [1314,909,515,445,1323,649,3213,1446,903,936,651]; %trace-specific 1
% numplot = [1314,1323,1570,1350,1612,515,445,863,1179,516,903,936,651,1232,2213];%trace-specific 2
% numplot = [1570,1612,516,903,703]; % trace-specific顺序来
% numplot=[3226,3819,137,132,2846,2898,2845];%shock cell
% numplot=[2950,553,3420,2323,290,3058];% shock ok
% numplot=[3226,148,516,2323,3226,1744,936,2653,553,3420,3486,2457,903,3858,290];

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

%% plot single neuron example in different trials

Cond_tone_ts = [240, 270; 360, 390; 480, 510];
Cond_trace_ts = [270, 290; 390, 410; 510, 530];
% 即新产生的每个数据点是333ms,以前是1s 30个点，现在是1s只有3个点；
figure;
sig=sig_sdff;
% 筛选一下pool
tone_trace=intersect(habituation.all_tone_final,habituation.all_trace_final);
tone_only=setdiff(habituation.all_tone_final,tone_trace);
trace_only=setdiff(habituation.all_trace_final,tone_trace);
tempnumplot = randperm(size(tone_trace,1), 5); 
numplot = tone_trace(tempnumplot);
% numplot =[2591	2290	2779	2536]; % tone-only cell
%numplot =[2506	1120	1270	1896	2001	677]; % tone-trace cell
%numplot =[1663	2076	3023	1999	3063	2375	871]; % trace-only cell
 %numplot =[2838	2728	2449	2817	1736	2925	2845	2843]; % shock cell
%numplot = [2779	2506  3023 2843] % tone-only,tone-trace,trace-only,shock-cell
% numplot = [677 2838	3023  2506 2779] % reverse sequence of cell order
numplot=[64 3010 1944]                            % habituation example cell
sigt=sig(numplot,660:1650);
sigt=sigt./max(sigt,[],2);
plot((sigt+(1:size(sigt,1))')');
hold on;axis off;box off;
xline1=720-660;xline2=810-660;xline22=870-660;xline3=1080-660;xline4=1170-660;xline44=1230-660;
xline5=1440-660;xline6=1530-660;xline66=1590-660;xline7=2178-660;xline8=2238-660;xline88=2298-660;
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
% area([xline7; xline8],[ylim; ylim],'FaceAlpha',0.2,'FaceColor','r','LineStyle','none');
% area([xline8; xline88],[ylim; ylim],'FaceAlpha',0.3,'FaceColor',[0 0.74 1],'LineStyle','none');

axis off;box off;


%% plot candidate neuron single trial
% 以前是300点代表10s，现在是变成了3hz的采样率，那就是30个点是10s；
numplot1 = 2591;
sigt=sig(numplot1,:);
sigt=sigt./max(sigt,[],2); % normalize by the peak.


b1=(sigt+(1:size(sigt,1))')' % 用来plot calcium trace的demo
figure('Position',[500, 500, 300,200]);
b2=b1(660:end,:);
plot(b2,'LineWidth',1,'color','k'); % 浅灰色 [0.82 0.82 0.82]
ylim([0.8,1.8]);
xline(30,'--r','LineWidth',1.5);xline(90,'--r','LineWidth',1.5);%xline(150,'--r','LineWidth',1.5);
box off;
axis off;
%%
figure('Position',[500, 500, 300,200]);
b3=b1(1176:1344,:);
plot(b3,'LineWidth',1,'color','k');
xline(30,'--r','LineWidth',1.5);xline(90,'--r','LineWidth',1.5);xline(150,'--r','LineWidth',1.5);
box off;
axis off;ylim([0.8,1.8]);

figure('Position',[500, 500, 600,500]);
b4=b1(1662:1830,:);
plot(b4,'LineWidth',1,'color',[0.82 0.82 0.82]);
xline(30,'--r','LineWidth',1.5);xline(90,'--r','LineWidth',1.5);xline(150,'--r','LineWidth',1.5);
box off;
axis off;

figure('Position',[500, 500, 600,500]);
b5=b1(2148:2316,:);
plot(b5,'LineWidth',1,'color',[0.82 0.82 0.82]);
xline(30,'--r','LineWidth',1.5);xline(90,'--r','LineWidth',1.5);xline(150,'--r','LineWidth',1.5);
box off;
axis off;

figure('Position',[500, 500, 600,500]);
b6=[b2 b3 b4 b5];
b7=mean(b6,2);
plot(b7,'LineWidth',1.4,'color','k');
xline(30,'--r','LineWidth',1.5);xline(90,'--r','LineWidth',1.5);xline(150,'--r','LineWidth',1.5);
box off;
axis off;











