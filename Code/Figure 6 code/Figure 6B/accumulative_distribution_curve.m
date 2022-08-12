%% 累积分布 example code
clc;clear;
M=100;N=1;
x=normrnd(2,1,M,N);
y=wblrnd(2,0.5,100,1);
h1=cdfplot(x);
hold on;
h2=cdfplot(y);
legend('正态分布','weibrnd分布')

%% sub cond trace delay peak activity
clc;clear;
filepath= 'D:\miniscope analysis\bt_miniscope\sub\sigraw\combine2\method3\conditioning3';
% filenames=dir([ filepath, '\*.mat']);
load(fullfile(filepath,'cond_sdff_cell.mat'));load(fullfile(filepath,'cond_sdff_data.mat'));
load(fullfile(filepath,'cond_poolTogether.mat'));
persistent1_activity=cond.all_trace_response(cond.all_persistent1,:,1);
persistent2_activity=cond.all_trace_response(cond.all_persistent2,:,2);
persistent3_activity=cond.all_trace_response(cond.all_persistent3,:,3);
persistent4_activity=cond.all_trace_response(cond.all_persistent4,:,4);
trial1=[];trial2=[];trial3=[];trial4=[];

for i=1:size(persistent1_activity,1)
[m,index] = max(persistent1_activity(i,:));
trial1(i)=index/30;
end

for i=1:size(persistent2_activity,1)
[m,index] = max(persistent2_activity(i,:));
trial2(i)=index/30;
end

for i=1:size(persistent3_activity,1)
[m,index] = max(persistent3_activity(i,:));
trial3(i)=index/30;
end

for i=1:size(persistent4_activity,1)
[m,index] = max(persistent4_activity(i,:));
trial4(i)=index/30;
end
% plot cdf 
h1=cdfplot(trial1); hold on;
h2=cdfplot(trial2); hold on;
h3=cdfplot(trial3); hold on;
h4=cdfplot(trial4); hold on;
legend('TFC trial 1','TFC trial 2','TFC trial 3','TFC trial 4','location','best');
grid off;

