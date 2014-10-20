clear all
close all
clc

%% Data Read In
Number = 'all';
[valid1,valid_gypsum] = RawDataRead(Number, 'Croc4');

%% Reference Sample
k = 400;         % Sample size, k number of fibres

dataGyps = SampleAlertData(valid_gypsum, k);
orientGyps = ProcessDBData(dataGyps);

%% Test Sample

nmax = 5;                       % for n number of test sets per percentage asbestos
percent_interval = 5 ;          % a measurement is taken at multiples of the percent interval from 0 to 100
median_diff = 3;

i=1;                            % for an i number of test
for percentage = 0:percent_interval:100
	test_sets(i) = {MultipleTestSetCreate(valid1, valid_gypsum, 200, percentage, nmax)};
    i=i+1;
end

%% Ansari - Bradley Test

alpha = 0.01;

steps = (100/percent_interval)+1;   % steps, how many data points are needed. 
                                    % E.g if the percent interval = 5%, 100/5 = 20. Including 0, means the steps equal 20 + 1

for A = 1:1:steps
    K = test_sets{A};
    for B = 1:nmax
        array = K{B} + median_diff;
        [h99, p99, stats] = ansaribradley(array, orientGyps, alpha, 'right');
        ansari_hypothesis(B,A) = h99;
        ansari_probability(B,A) = p99;
        W(B,A) = stats.W;
        Wstar(B,A) = stats.Wstar;  
    end
end

%% Plotting
alpha = norminv(alpha);
plot_percent = 0:percent_interval:100;
row1 = Wstar(1,1:steps);                                    

% Average
z = 1;
for interval = 1:steps
    averaged_row(z) = sum(Wstar(1:nmax,interval))/nmax;
    z = z+1;
end

% Errors
minimum_val = min(Wstar);
maximum_val = max(Wstar);

min_error = averaged_row - minimum_val;
max_error = averaged_row - maximum_val;

% Plots
figure(1)       % 1 row
hold on
plot(plot_percent, row1);
line([0;100],[alpha;alpha],'color', [1 0 0],'linewidth', 1);

xlabel('Percent Asbestos');
ylabel('W*');
title('W*-statistic as the Concentration of Crocidolite Fibres in the Test Sample Increases');
hold off

figure(2)       % Averaged
hold on
errorbar(plot_percent,averaged_row,min_error,max_error,'k');
plot(plot_percent, averaged_row);
line([-10;110],[alpha;alpha],'color', [1 0 0],'linewidth', 1);

xlabel('Percent Asbestos');
ylabel('W*');
title('Average W*-statistic as the Concentration of Crocidolite Fibres in the Test Sample Increases');
hold off