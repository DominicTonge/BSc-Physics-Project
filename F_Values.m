function [ FValue, FCritical, HypothesisTest ] = F_Values(test_sets, orientGyps, alpha, nmax, percent_interval)
% Creates an array containing the F statistic for each test sample and also
% calculates the critical F value for the sample size.
% 
%   FStat = The array containing the F statistic for each test set.
%   alpha = Confidence level, (1-alpha)*100 = significance level percentage
%   test_sets = the mixed asbestos test sets


%% F Critical
J = test_sets{1};                  % J = the first orientation change array
n1 = numel(J{1});
n2 = numel(orientGyps);
FCritical = finv(1-alpha,(n1-1),(n2-1));

%% F Statistic

steps = (100/percent_interval)+1;   % steps, how many data points are needed. 
                                    % E.g if the percent interval = 5%, 100/5 = 20. Including 0, means the steps equal 20 + 1

for A = 1:1:steps
    K = test_sets{A};
    for B = 1:nmax
        array = K{B};
        [H,~,~,fstat] = vartest2(array, orientGyps, alpha, 'right');       
        FValue(B,A) = fstat.fstat;
        HypothesisTest(B,A) = H;
    end
end

end

