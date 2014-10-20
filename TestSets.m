clear all
clc

%% Raw Data

Number = 1000;

[orient1, orient2, orient3, orientGyps, data1, data2, data3, dataGyps, valid1, valid2, valid3, validGyps] = RawDataRead(Number);



%%

k = 80;
percentage = 90;
alpha = 0.05;
nmax = 2;

%% Gypsum

dataGyps = SampleAlertData(validGyps, k);
orientGyps = ProcessDBData(dataGyps);

%% test sample
% creates a cell array contain n number of orientation change arrays
for n = 1:nmax
    testorient(n) = {CrocGypsTestSetCreate(valid1, validGyps, k, percentage)};   
end
%% F-Critical

J = testorient{1};                  % J = the first orientation change array
n1 = numel(J);
n2 = numel(orientGyps);
FCritical = finv(1-alpha,(n1-1),(n2-1));

%% F-value
[~,~,~,fstat] = vartest2(testorient{1}, orientGyps, alpha, 'right');
FValue = fstat.fstat;

%%

FValue
FCritical