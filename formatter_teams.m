clear
clc

filename = 'NBAPlayerStats2013-2014TEAMS_FORMATTED.csv';
M = csvread(filename, 1);
cond = M(:,7) <= prctile(M(:,7),25);
M(cond,:) = [];

csvwrite('NBAPlayerStats2013-2014TEAMS_FORMATTED_PRUNED.csv', M)