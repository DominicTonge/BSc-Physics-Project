clear all
ReadAlertData('reset');

%% Data Input

% Number = input('Input the number of profiles to be read in from the .csv data files ');
% HistBins = input('Input the number of bins to be used on the histograms ');

Number = 1000;
HistBins = 30;

% .csv Data files
profiles1 = 'Crocidolite_BoxedUnit_test01_0000.csv';
profiles2 = 'Crocidolite_BoxedUnit_test01_0000_0000.csv';
profiles3 = 'Crocidolite_BoxedUnit_test01_0000_0001.csv';
profiles4 = 'gyp_sampleFR100_sheathFR185_0001_0000_0000.csv';

% Fibre orientation data from Crocidolite data 1
Crocidolite1 = ReadAlertData(profiles1, Number, 'findfibres', true);
[ArrayCrocidolite1, ~] = ProcessDBData(Crocidolite1);
Analyse = AnalyseFibres(ArrayCrocidolite1);

% Fibre orientation data from Crocidolite data 2
Crocidolite2 = ReadAlertData(profiles2, Number, 'findfibres', true);
[ArrayCrocidolite2, ~] = ProcessDBData(Crocidolite2);

% Fibre orientation data from Crocidolite data 3
Crocidolite3 = ReadAlertData(profiles3, Number, 'findfibres', true);
[ArrayCrocidolite3, ~] = ProcessDBData(Crocidolite3);

% Fibre orientation data from Gypsum data
Crocidolite1 = ReadAlertData(profiles4, Number, 'findfibres', true);
[ArrayGypsum, ~] = ProcessDBData(Crocidolite1);

%% Variance

% Number of fibres in data set
Ncroc1 = numel(ArrayCrocidolite1);
Ncroc2 = numel(ArrayCrocidolite2);
Ncroc3 = numel(ArrayCrocidolite3);
Ngyps = numel(ArrayGypsum);

% Crocidolite data 1 Variance
for k = 1:Ncroc1
    muCroc1 = (sum(ArrayCrocidolite1(1,k))/Ncroc1);                                % Mean
    VarianceCroc1 = (sum(((ArrayCrocidolite1(1,k) - muCroc1).^2))/(Ncroc1-1));  % Sample Variance
end

% Crocidolite data 2 Variance
for k = 1:Ncroc2
    muCroc2 = (sum(ArrayCrocidolite2(1,k))/Ncroc2);                                % Mean
    VarianceCroc2 = (sum(((ArrayCrocidolite2(1,k) - muCroc2).^2))/(Ncroc2-1));  % Sample Variance
end

% Crocidolite data 3 Variance
for k = 1:Ncroc3
    muCroc3 = (sum(ArrayCrocidolite3(1,k))/Ncroc3);                                % Mean
    VarianceCroc3 = (sum(((ArrayCrocidolite3(1,k) - muCroc3).^2))/(Ncroc3-1));  % Sample Variance
end

% Gypsum Variance
for k = 1:Ngyps
    muGyps = (sum(ArrayGypsum(1,k))/Ngyps);                                % Mean
    VarianceGyps = (sum(((ArrayGypsum(1,k) - muGyps).^2))/(Ngyps-1));    % Sample Variance
end

V1 = VarianceCroc1;
V2 = VarianceCroc2;
V3 = VarianceCroc3;
VG = VarianceGyps;

%% Histogram
figure()

subplot(2,2,1)
hist(ArrayCrocidolite1, HistBins);
xlabel('Orientation Change (Degrees)');
ylabel('Frequency');
title(['Distribution for Crocidolite 1, Variance = ' num2str(V1)]);


subplot(2,2,2)
hist(ArrayCrocidolite2, HistBins);
xlabel('Orientation Change (Degrees)');
ylabel('Frequency');
title(['Distribution for Crocidolite 2, Variance = ' num2str(V2)]);

subplot(2,2,3)
hist(ArrayCrocidolite3, HistBins);
xlabel('Orientation Change (Degrees)');
ylabel('Frequency');
title(['Distribution for Crocidolite 3, Variance = ' num2str(V3)]);

subplot(2,2,4)
hist(ArrayGypsum, HistBins);
xlabel('Orientation Change (Degrees)');
ylabel('Frequency');
title(['Distribution for Gypsum, Variance = ' num2str(VG)]);