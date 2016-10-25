% NBA Player Value
% CSCI-B 490 Project

%% Read File

%Read 2013-2014 NBA Player Stats


filename = 'NBAPlayerStats2013-2014FORMATTED.csv';
M = csvread(filename,1);

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

sortrows(dTotalValue,1)

%% Figures
% These are the various figure calculations for all the players

% Box Plot Points
figure
boxplot(M(1:end,26))
title('Points of all NBA Players')
ylabel('Total Points')

% Box Plot PPG
figure
boxplot(ppg)
title('PPG of all NBA Players')
ylabel('Points Per Game')

% Scatter Plot Points v. Minutes - Polynomial
figure
pf = polyfit(points, minutes, 2);
tpf = 0:0.1:3000;
ypf = polyval(pf,tpf);
plot(points,minutes,'o',tpf,ypf);
xlabel('Total Points') % x-axis label
ylabel('Minutes Played') % y-axis label
title('Points v. Minutes');

% Scatter Plot Points v. Minutes - 3rd Degree
figure
pf = polyfit(points, minutes, 3);
tpf = 0:0.1:3000;
ypf = polyval(pf,tpf);
plot(points,minutes,'o',tpf,ypf);
xlabel('Total Points') % x-axis label
ylabel('Minutes Played') % y-axis label
title('Points v. Minutes');

% Scatter Plot Points v. Minutes - Linear
figure
scatter(points,minutes);
xlabel('Total Points') % x-axis label
ylabel('Minutes Played') % y-axis label
title('Points v. Minutes');

% Scatter Plot PPG v. Minutes
figure
scatter(ppg,mpg);
xlabel('Points Per Game') % x-axis label
ylabel('Minutes Per Game') % y-axis label
title('Points Per Game v. Minutes Per Game');

% Scatter Plot PPG v. MPG with KD & Charlie Villanueva
figure
[N,r] = size(ppg);
colorMap = [zeros(N, 1), zeros(N, 1), ones(N,1)];
for k = 1 : length(mpg)
	if id(k) == 134 % KD
		colorMap(k, :) = [1,0,0]; % Red
    elseif id(k) == 447 % Villanueva
		colorMap(k, :) = [0,1,0]; % Green
	else
		colorMap(k, :) = [1,1,0]; % Yellow
	end
end
scatter(ppg,mpg,25,colorMap);
cv = strcat('\uparrow Charlie Villanueva = ',num2str(dPoints(447),6));
text(ppg(447),mpg(447),cv,'VerticalAlignment','top');
kd = strcat('\downarrow Kevin Durant = ',num2str(dPoints(134),6));
text(ppg(134),mpg(134),kd,'VerticalAlignment','bottom');
xlabel('Points Per Game') % x-axis label
ylabel('Minutes Per Game') % y-axis label
title('Points Per Game v. Minutes Per Game - Kevin Durant, Charlie Villanueva');
lsline;

% Scatter Plot Points v. Minutes with KD & Charlie Villanueva
figure
[N,r] = size(dPoints);
% Initialize a blue map
colorMap = [zeros(N, 1), zeros(N, 1), ones(N,1)];
% If d >= -10, make the markers red.
for k = 1 : length(minutes)
	if id(k) == 134
		colorMap(k, :) = [1,0,0]; % Red
    elseif id(k) == 447 % VillaNueva
		colorMap(k, :) = [0,1,0]; % Green
	else
		colorMap(k, :) = [1,1,0]; % Yellow
	end
end
scatter(points,minutes,25,colorMap);
cv = 'Charlie Villanueva';
text(ppg(447),mpg(447),cv,'VerticalAlignment','middle');
kd = 'Kevin Durant';
text(points(134),minutes(134),kd,'VerticalAlignment','bottom');
xlabel('Points') % x-axis label
ylabel('Minutes') % y-axis label
title('Points v. Minutes - Kevin Durant, Charlie Villanueva');
lsline;

% Scatter of PPG v. MPG - PPG Outliers
figure
[N,r] = size(ppg);
% Initializemap
colorMap = [zeros(N, 1), zeros(N, 1), ones(N,1)];
for k = 1 : length(ppg) 
	if ppg(k) > 24
		colorMap(k, :) = [1,0,0]; % Red
	else
		colorMap(k, :) = [1,1,0]; % Yellow
	end
end
scatter(ppg,mpg,25,colorMap);
hold on
upperEnd = (1.5*(prctile(ppg,75) - prctile(ppg,25))) + prctile(ppg,75);
plot([upperEnd upperEnd],[25 45],'b')
plot([prctile(ppg,75) prctile(ppg,75)],[1 60],'b')
plot([prctile(ppg,50) prctile(ppg,50)],[1 60],'r')
plot([prctile(ppg,25) prctile(ppg,25)],[1 60],'b')
hold off
xlabel('Points Per Game') % x-axis label
ylabel('Minutes Per Game') % y-axis label
title('Points Per Game v. Minutes Per Game - PPG Outliers');
lsline;

% Scatter Plot APG v. MPG with KD
figure
[N,r] = size(apg);
% Initialize a blue map
colorMap = [zeros(N, 1), zeros(N, 1), ones(N,1)];
% If d >= -10, make the markers red.
for k = 1 : length(apg)
	if id(k) == 134 % KD
		colorMap(k, :) = [1,0,0]; % Red
	else
		colorMap(k, :) = [1,1,0]; % Yellow
	end
end
scatter(apg,mpg,25,colorMap);
kd = strcat('\downarrow Kevin Durant = ',num2str(dAssists(134),6));
text(apg(134),mpg(134),kd,'VerticalAlignment','bottom');
xlabel('Assists Per Game') % x-axis label
ylabel('Minutes Per Game') % y-axis label
title('Assists Per Game v. Minutes Per Game - Kevin Durant');
lsline;

% Scatter Plot SPG v. MPG with KD
figure
[N,r] = size(spg);
colorMap = [zeros(N, 1), zeros(N, 1), ones(N,1)];
% If d >= -10, make the markers red.
for k = 1 : length(spg)
	if id(k) == 134 % KD
		colorMap(k, :) = [1,0,0]; % Red
	else
		colorMap(k, :) = [1,1,0]; % Yellow
	end
end
scatter(spg,mpg,25,colorMap);
kd = strcat('\downarrow Kevin Durant = ',num2str(dSteals(134),6));
text(spg(134),mpg(134),kd,'VerticalAlignment','bottom');
xlabel('Steals Per Game') % x-axis label
ylabel('Minutes Per Game') % y-axis label
title('Steals Per Game v. Minutes Per Game - Kevin Durant');
lsline;

% Scatter Plot BPG v. MPG with KD
figure
[N,r] = size(bpg);
colorMap = [zeros(N, 1), zeros(N, 1), ones(N,1)];
% If d >= -10, make the markers red.
for k = 1 : length(bpg)
	if id(k) == 134 % KD
		colorMap(k, :) = [1,0,0]; % Red
	else
		colorMap(k, :) = [1,1,0]; % Yellow
	end
end
scatter(bpg,mpg,25,colorMap);
kd = strcat('\downarrow Kevin Durant = ',num2str(dBlocks(134),6));
text(bpg(134),mpg(134),kd,'VerticalAlignment','bottom');
xlabel('Blocks Per Game') % x-axis label
ylabel('Minutes Per Game') % y-axis label
title('Blocks Per Game v. Minutes Per Game - Kevin Durant');
lsline;

% Scatter Plot RPG v. MPG with KD
figure
[N,r] = size(rpg);
colorMap = [zeros(N, 1), zeros(N, 1), ones(N,1)];
% If d >= -10, make the markers red.
for k = 1 : length(rpg)
	if id(k) == 134 % KD
		colorMap(k, :) = [1,0,0]; % Red
	else
		colorMap(k, :) = [1,1,0]; % Yellow
	end
end
scatter(rpg,mpg,25,colorMap);
kd = strcat('\downarrow Kevin Durant = ',num2str(dRebounds(134),6));
text(rpg(134),mpg(134),kd,'VerticalAlignment','bottom');
xlabel('Rebounds Per Game') % x-axis label
ylabel('Minutes Per Game') % y-axis label
title('Rebounds Per Game v. Minutes Per Game - Kevin Durant');
lsline;
