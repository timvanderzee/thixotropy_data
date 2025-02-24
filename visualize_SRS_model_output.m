clear all; close all; clc


%% Effect of activation
load('Hill_ISIs=1_AMPs=383.mat')
id = [1 3 5];

Cmap = interp1([0, 1], [color(2,:); 1 .9 .7], linspace(0, 1, length(id)));
Cmap2 = interp1([0, 1], [0 0 0;.8 .8 .8], linspace(0, 1, length(id)));
Cmap3 = interp1([0, 1], [color(1,:); .7 .9 1], linspace(0, 1, length(id)));

figure(1)
for i = 1:length(id)
    subplot(4,2,1)
    plot(ExpData.texp(:,id(i)), ExpData.Lexp(:,id(i)),'color',Cmap2(i,:),'linewidth',2); hold on; box off
    
    subplot(4,2,3)
    plot(ExpData.texp(:,id(i)), ExpData.Fexp(:,id(i)),'color',Cmap2(i,:),'linewidth',2); hold on; box off
    plot(ModData.texp(:,id(i)), Fmodel(:,id(i)),'color',Cmap(i,:),'linewidth',2); hold on
end

load('3state_ISIs=1_AMPs=383.mat')


for i = 1:length(id)
    plot(ModData.texp(:,id(i)), Fmodel(:,id(i)),'color',Cmap3(i,:),'linewidth',2); hold on
end

subplot(421)
xlim([-.25 .15])
xline(0,'k--')
ylabel('Length')
title('Effect of activation')

subplot(423)
xlim([-.25 .15])
xline(0,'k--')
xlabel('Time (s)')
ylabel('Force (kPa)')


%% Effect of AMP
% close all
id = 3:5;
ix = 3;

figure(1)

for i = 1:length(id)
    load(['Hill_ISIs=1_AMPs=',num2str(AMPs(id(i))),'.mat'],'ExpData','ModData','Fmodel')

    subplot(4,2,2)
    plot(ExpData.texp(:,ix), ExpData.Lexp(:,ix),'color',Cmap2(i,:),'linewidth',2); hold on; box off
    
    subplot(4,2,4)
    plot(ExpData.texp(:,ix), ExpData.Fexp(:,ix),'color',Cmap2(i,:),'linewidth',2); hold on; box off
    plot(ModData.texp(:,ix), Fmodel(:,ix),'color',Cmap(i,:),'linewidth',2); hold on

    load(['3state_ISIs=1_AMPs=',num2str(AMPs(id(i))),'.mat'],'ExpData','ModData','Fmodel')

    plot(ModData.texp(:,ix), Fmodel(:,ix),'color',Cmap3(i,:),'linewidth',2); hold on
end

subplot(422)
xlim([-.25 .15])
xline(0,'k--')
ylabel('Length')
title('Effect of AMP')

subplot(424)
xlim([-.25 .15])
xline(0,'k--')
xlabel('Time (s)')
ylabel('Force (kPa)')

%% Effect of ISI
% close all
id = 4:-1:2;
ix = 3;

figure(1)
for i = 1:length(id)

    if i == 1
        shift = .4;
    else
        shift = 0;
    end
    load(['Hill_ISIs=',num2str(ISIs(id(i))),'_AMPs=383.mat'],'ExpData','ModData','Fmodel')

    subplot(4,2,5:6)
    plot(ExpData.texp(:,ix)+ISIs(id(i))/1000-shift, ExpData.Lexp(:,ix),'color',Cmap2(i,:),'linewidth',2); hold on; box off
   
    subplot(4,2,7:8)
    plot(ExpData.texp(:,ix)+ISIs(id(i))/1000-shift, ExpData.Fexp(:,ix),'color',Cmap2(i,:),'linewidth',2); hold on; box off
    plot(ModData.texp(:,ix)+ISIs(id(i))/1000-shift, Fmodel(:,ix),'color',Cmap(i,:),'linewidth',2); hold on

    load(['3state_ISIs=',num2str(ISIs(id(i))),'_AMPs=383.mat'],'ExpData','ModData','Fmodel')

    plot(ModData.texp(:,ix)+ISIs(id(i))/1000-shift, Fmodel(:,ix),'color',Cmap3(i,:),'linewidth',2); hold on
end

subplot(4,2,5:6)
xlim([-.25 .7])
xline(0,'k--')
ylabel('Length')
title('Effect of ISI')

subplot(4,2,7:8)
xlim([-.25 .7])
xline(0,'k--')
xlabel('Time (s)')
ylabel('Force (kPa)')



%% Summary plots

if strcmp(type,'pCa')
    plot(yM.Fpre, yM.SRS./yM_ref.SRS,'linewidth',2); hold on
    plot(yD.Fpre, yD.SRS./yD_ref.SRS,':','color',[.5 .5 .5],'linewidth',2,'marker','o');
    xlabel('Pre-stretch force (kPa)')
    xlim([0 max(yD.Fpre)])

    legend(model, 'data (n=3)', 'location','best')
    legend boxoff
    ylim([0 2.5])

elseif strcmp(type,'AMP')
    plot(ModData.AMPs(:,1), yM.SRS./yM_ref.SRS,'linewidth',2); hold on
    plot(ExpData.AMPs(:,1), yD.SRS./yD_ref.SRS,':','color',[.5 .5 .5],'linewidth',2,'marker','o');
    xlabel('Amplitude (L_0)')
    ylim([0 1.5])

elseif strcmp(type,'ISI')
    semilogx(ModData.ISI, yM.SRS./yM_ref.SRS,'linewidth',2); hold on
    semilogx(ExpData.ISI, yD.SRS./yD_ref.SRS,':','color',[.5 .5 .5],'linewidth',2,'marker','o');
    xlabel('Inter-stretch interval (s)')
    xlim([min(Data.ISIs) max(Data.ISIs)])
    ylim([0 1.5])
end






