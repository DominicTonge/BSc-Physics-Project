clear all
close all
clc

%% Raw Data
Number = 'all';
[valid1, valid_gypsum] = RawDataRead(Number, 'Croc4');

%% Gypsum Sample Creation

k = 400;         % Sample size, k number of fibres

dataGyps = SampleAlertData(valid_gypsum, k);
orientGyps = ProcessDBData(dataGyps);

%% Test Sample Creation

nmax = 30;                      % for n number of test sets per percentage asbestos
percent_interval = 5 ;          % a measurement is taken at multiples of the percent interval from 0 to 100

i=1;                            
for percentage = 0:percent_interval:100
	test_sets(i) = {MultipleTestSetCreate(valid1, valid_gypsum, k, percentage, nmax)};
    i=i+1;
end

%% F-test
alpha = 0.01;                   % alpha = Confidence level, (1-alpha)*100 = significance level percentage

[FValue, FCritical, HypothesisTest] = F_Values(test_sets, orientGyps, alpha, nmax, percent_interval);

steps = (100/percent_interval)+1;

%%%% Average F-Statistic at each percentage value
z = 1;
for interval = 1:steps
    averaged_row(z) = sum(FValue(1:nmax,interval))/nmax;
    z = z+1;
end

%% Errors

minimum_val = min(FValue);
maximum_val = max(FValue);

min_error = averaged_row - minimum_val;
max_error = averaged_row - maximum_val;

%% Plots

plot_percent = 0:percent_interval:100;
row1 = FValue(1,1:steps);

%%%% First group of test sets, % = 0 - 100
figure(1)
hold on
plot(plot_percent, row1);
line([0;100],[FCritical;FCritical],'color', [1 0 0],'linewidth', 1);

xlabel('Percent Asbestos');
ylabel('F-Statistic');
title('An Individual set of results');
hold off

%%%% Average Plot
figure(2)
hold on
errorbar(plot_percent,averaged_row,min_error,max_error,'k');
plot(plot_percent, averaged_row,'b');
line([0;110],[FCritical;FCritical],'LineWidth', 1,'color', [1 0 0]);

xlabel('Percent Asbestos');
ylabel('F-Statistic');
title('Average F-statistic as the Concentration of Chrysotile Fibres in the Test Sample Increases');
hold off