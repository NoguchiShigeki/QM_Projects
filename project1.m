% clear workspace and interactive window
clc
clear all
close all

% Vars
f = fred
startdate = '01/01/1954';
enddate = '01/01/2022';
japanData = fetch(f,'JPNRGDPEXP',startdate,enddate);
ukData = fetch(f,'NGDPRSAXDCGBQ',startdate,enddate);

lnjapanGDP = log(japanData.Data(:,2)); 
lnukGDP = log(ukData.Data(:,2)); 

lam = 1600;

[japan_cycle, japan_trend] = hpfilter(lnjapanGDP, lam);
[uk_cycle, uk_trend] = hpfilter(lnukGDP, lam);

japan_std = std(japan_cycle);
uk_std = std(uk_cycle);

fprintf('Standard deviation of UK: %f\n', uk_std);
fprintf('Standard deviation of Japan: %f\n', japan_std);

% correlation = corrcoef(japan_cycle, uk_cycle);
correlation = corrcoef(japanData,ukData)

fprintf('Correlation coefficient between UK and Japan: %f\n', correlation(1, 2));

% fprintf('Standard deviation of UK: %f\n', uk_std);
% fprintf('Standard deviation of Japan: %f\n', japan_std);
% fprintf('Correlation coefficient between UK and Japan: %f\n', correlation(1, 2));
figure
title('Detrended log(real GDP) 1954Q1-2019Q1'); hold on
plot(q, ytilde,'b', q, zerovec,'r')
datetick('x', 'yyyy-qq')
