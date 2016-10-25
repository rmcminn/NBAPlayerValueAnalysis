% NBA Player Value
% CSCI-B 490 Project

%% Read File

%Read 2013-2014 NBA Player Stats


filename = 'NBAPlayerStats2013-2014PRUNED.csv';
M = csvread(filename);

%% Calculating Relevant Values

% Points Per Game
ppg = (M(:,26)./M(:,2));
% Minutes Per Game
mpg = (M(:,4)./M(:,2));
% Assists Per Game
apg = (M(:,21)./M(:,2));
% Steals Per Game
spg = (M(:,22)./M(:,2));
% Blocks Per Game
bpg = (M(:,23)./M(:,2));
% Rebounds Per Game
rpg = (M(:,20)./M(:,2));

% Minutes, Points, and ID
minutes = M(1:end,4);
points = M(1:end,26);
id = M(1:end,1);

%dPoints
p = polyfit(ppg, mpg, 1);
yVal = polyval(p, ppg);
dPoints = yVal - mpg;
%dAssists
p = polyfit(apg, mpg, 1);
yVal = polyval(p, apg);
dAssists = yVal - mpg;
%dSteals
p = polyfit(spg, mpg, 1);
yVal = polyval(p, spg);
dSteals = yVal - mpg;
%dBlocks
p = polyfit(bpg, mpg, 1);
yVal = polyval(p, bpg);
dBlocks = yVal - mpg;
%dRebounds
p = polyfit(rpg, mpg, 1);
yVal = polyval(p, rpg);
dRebounds = yVal - mpg;

%dTotalValue
dValues = [dPoints, dAssists, dSteals, dBlocks, dRebounds];
dTotalValue = mean(dValues,2);
dTotalValue = [id, dTotalValue,dValues];

sortrows(dTotalValue,2)

%% Figures

% none currently