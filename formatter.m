clear
clc

filename = 'NBAPlayerStats2013-2014FORMATTED.csv';
M = csvread(filename, 1);
cond = M(:,4) <= prctile(M(:,4),25);
prctile(M(:,4),25)
M(cond,:) = [];

csvwrite('NBAPlayerStats2013-2014PRUNED.csv', M)


