function [] = QuadHistPlot(histdata1, histdata2, histdata3, histdata4, xlabel1, ylabel1, title1, xlabel2, ylabel2, title2, xlabel3, ylabel3, title3, xlabel4, ylabel4, title4, HistBins)
%
% histdata1, 2, 3 & 4 = data to be plotted into histogram
% xlabel1, 2, 3 & 4 = xlabel for each histogram
% ylabel1, 2, 3 & 4 = ylabel for each histogram
% title1, 2, 3 & 4 = title for each histogram
% 
% 1 = top left
% 2 = top right
% 3 = bottom left
% 4 = bottom right


figure(1)

HistBins = 20;

subplot(2,2,1)
hist(histdata1, HistBins);
xlabel(xlabel1);
ylabel(ylabel1);
title(title1);


subplot(2,2,2)
hist(histdata2, HistBins);
xlabel(xlabel2);
ylabel(ylabel2);
title(title2);

subplot(2,2,3)
hist(histdata3, HistBins);
xlabel(xlabel3);
ylabel(ylabel3);
title(title3);

subplot(2,2,4)
hist(histdata4, HistBins);
xlabel(xlabel4);
ylabel(ylabel4);
title(title4);


end

