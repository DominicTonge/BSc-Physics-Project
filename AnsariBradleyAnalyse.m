clear all
close all
clc

%% Raw Data
[valid1, valid_gypsum1] = RawDataRead('all', 'Croc4');   % Test Sample

%% Constants

k_ref = 400;        % Sample size
k_test = 200;
alpha = 0.01;
num_trials = 100;     % Number of trials per experiment (test sets)
experiments = 1;      % Number of reference samples
median_diff = 3;      % Difference in median

for e = 1:experiments
% Reference
    load('C:\Users\Dominic\Documents\University work\Physics\Project\Matlab\My Code\Orientation Change\AnsariBradley\Ansari Bradley Analyse Results\TESTREFERENCE.mat');
    reference_set = ProcessDBData(TESTREFERENCE);
    
% Trials

    for trials = 1:num_trials
        for percentage = 1:100
            
            test_set = AsbGypsTestSetCreate(valid1, valid_gypsum1, k_test, percentage); % Test set

            test_set = test_set + median_diff;
            h = ansaribradley(test_set, reference_set, alpha, 'right');                 % Ansari Bradley Test

            if h == 1
                detection(trials, e) = percentage;      % Creates array, column = experiment, row = trial 
                break;
            end

        end
    end
end

%% Plotting

for e = 1:experiments
    mean(e) = (sum(detection(1:num_trials,e))/num_trials);
    DataHist(detection(1:num_trials,e),'bar','bins',20);
end

hold on
DataHist(mean,'bar','bins',10);
title('Mean of Means')
hold off