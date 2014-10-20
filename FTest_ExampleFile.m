clear all
clc

%% Raw Data

Number = 500;

[orient1, orient2, orient3, orientGyps, valid1, valid2, valid3, validGyps] = RawDataRead(Number);


%% Variance

SD1 = std(orient1);
Var1 = SD1^2;

SD2 = std(orient2);
Var2 = SD2^2;

SD3 = std(orient3);
Var3 = SD3^2;

SDGyps = std(orientGyps);
VarGyps = SDGyps^2;

% Hypothesis f test
alpha = 0.01;  % (1-alpha)*100 = significance level percentage

% If H = 0, null hypothesis is accepted, variances of the two samples are
% equal to the given significance level. 
% H = 1, null hypothesis rejected.
[H1, P1, ~, fstat1] = vartest2(orient1, orient2, alpha, 'right');
[H2, ~, ~, fstat2] = vartest2(orient2, orientGyps, alpha, 'right');
[H3, ~, ~, fstat3] = vartest2(orient1, orientGyps, alpha, 'right');

% The following returns the degrees of freedom, or v numbers, for each of
% the above hypothesis tests
H1V1 = fstat1.df1;
H1V2 = fstat1.df2;

H2V1 = fstat2.df1;
H2V2 = fstat2.df2;

H3V1 = fstat3.df1;
H3V2 = fstat3.df2;

% returns the f-value calculated in each hypothesis test
fstat1.fstat
fstat2.fstat
fstat3.fstat

% returns the critical f-value for a significnce level alpha, of the two 
% degrees of freedom values of the two sets of data 
finv(1-alpha,H1V1,H1V2)
finv(1-alpha,H2V1,H2V2)
finv(1-alpha,H3V1,H3V2)



%%
% figure(1)
% 
% QuadHist = QuadHistPlot(orient1, orient2, orient3, orientGyps, 'Orientation Change (Degrees)', 'Frequency',...
%     ['Distribution for Crocidolite 1, Variance = ' num2str(Var1)], 'Orientation Change (Degrees)', 'Frequency',...
%     ['Distribution for Crocidolite 2, Variance = ' num2str(Var2)], 'Orientation Change (Degrees)', 'Frequency',...
%     ['Distribution for Crocidolite 3, Variance = ' num2str(Var3)],'Orientation Change (Degrees)', 'Frequency',...
%     ['Distribution for Gypsum, Variance = ' num2str(VarGyps)], 20);

