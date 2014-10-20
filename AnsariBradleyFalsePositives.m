clear all
close all
clc

Number = 'all';
[valid1,valid_gypsum] = RawDataRead(Number, 'Croc4');

%% Sampling

k = 400;            % sample size
nmax = 1000;        % number of samples
percentage = 0;    % percentage mix
alpha99 = 0.01;     % 99% confidence
alpha95 = 0.05;     % 95% confidence
median_diff = 3;

% Gypsum
dataGyps = SampleAlertData(valid_gypsum, k);
orientGyps = ProcessDBData(dataGyps);

% Asbestos
test_sets = MultipleTestSetCreate(valid1, valid_gypsum, k, percentage, nmax);


%% Ansari-Bradley Test
i = 1;
for j = 1:nmax
    h99(i) = ansaribradley((test_sets{j}+median_diff), orientGyps, alpha99,'right');
    [~,p99(i)] = ansaribradley((test_sets{j}+median_diff), orientGyps, alpha99,'right');
    [~,~, stats(i)] = ansaribradley((test_sets{j}+median_diff), orientGyps, alpha99,'right');
    W(i) = stats(i).W;
    Wstar(i) = stats(i).Wstar;      % Wstar = approximate z statistic
    i = i + 1;
end


%% Number of Samples where Asbestos has been Detected
% m = 1;
% for n = 1:nmax  
%     if h99(n) == 1
%         hypothesis99(m) = h99(n);
%         m = m + 1;
%     end;
% end

% asbesos_detected = numel(hypothesis99);  % if h99 contains no 1's, an error comes up

%
% m = 1;
% for n = 1:nmax  
%     if Wstar(n) < -2.33
%         Wstar99(m) = Wstar(n);
%         m = m + 1;
%     end;
% end
% 
% NumWstar99 = numel(Wstar99)
%% Plotting

crit = norminv(alpha99);

figure(1)
hold on
scatter(1:nmax,Wstar);
line([1;nmax],[crit;crit],'color', [1 0 0]);
hold off
% axis([ 1 1000 0 1]);

% figure(2)
% scatter(1:nmax,p99);
% axis([ 1 1000 0 0.5]);
% 
% figure(3)
% scatter(1:nmax,p99);
% axis([ 1 1000 0 0.25]);
% 
% figure(4)
% scatter(1:nmax,p99);
% axis([ 1 1000 0 0.15]);


%%
% figure(5)
% plot(W)

% figure(6)
% plot(Wstar)



