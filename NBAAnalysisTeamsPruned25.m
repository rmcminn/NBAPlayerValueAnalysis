% NBA Player Value
% CSCI-B 490 Project

%% Read File

%Read 2013-2014 NBA Player Stats


filename = 'NBAPlayerStats2013-2014TEAMS_FORMATTED_PRUNED.csv';
M = csvread(filename);

%% Calculating Relevant Values

% Points Per Game
ppg = (M(:,29)./M(:,5));
% Minutes Per Game
mpg = (M(:,7)./M(:,5));
% Assists Per Game
apg = (M(:,24)./M(:,5));
% Steals Per Game
spg = (M(:,25)./M(:,5));
% Blocks Per Game
bpg = (M(:,26)./M(:,5));
% Rebounds Per Game
rpg = (M(:,23)./M(:,5));

% Minutes, Points, and ID
minutes = M(1:end,7);
points = M(1:end,29);
id = M(1:end,1);
team = M(1:end,4);

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

sortrows(dTotalValue,2);

%% Team Values
dTVTeams = [];
total = 0;
playerCount = 0;
for x = 1:30
    for y = 1:411 % using total rows in TEAMS_FORMATTED_PRUNED
        if M(y,4) == x
            total = total + dTotalValue(y,2);
            playerCount = playerCount + 1;
            avg = total / playerCount;
        end
    end
    dTVTeams = [dTVTeams; x, avg];
    total = 0;
    playerCount = 0;
    avg = 0;
end

sortrows(dTVTeams, 2)

%% Season Testing
actualWL = [.463;
    .305;
    .537;
    .524;
    .585;
    .402;
    .598;
    .439;
    .354;
    .622;
    .659;
    .683;
    .695;
    .329;
    .610;
    .659;
    .183;
    .488;
    .415;
    .451;
    .720;
    .280;
    .232;
    .585;
    .659;
    .341;
    .756;
    .585;
    .305;
    .537];
accuracy = [];
for x = 1:10000
    WLMatrix = [dTVTeams(:,1), zeros(30,1),zeros(30,1)];


    stdVariance = std(dTVTeams(:,2))*4;

    for z = 1:3
        for x = 1:30
            for y = x:30
                if x ~= y
                   rx = -stdVariance + (stdVariance+stdVariance)*rand;
                   ry = -stdVariance + (stdVariance+stdVariance)*rand;
                   xVal = dTVTeams(x,2) + rx;
                   yVal = dTVTeams(y,2) + ry;
                   if xVal > yVal
                       WLMatrix(x,2) = WLMatrix(x,2) + 1;
                       WLMatrix(y,3) = WLMatrix(y,3) + 1;
                   elseif yVal > xVal
                       WLMatrix(y,2) = WLMatrix(y,2) + 1;
                       WLMatrix(x,3) = WLMatrix(x,3) + 1;
                   end
                end
            end
        end
    end
    WLPer = WLMatrix(:,2) / (WLMatrix(:,2) + WLMatrix(:,3));
    
    errorM = abs((actualWL-WLPer(:,1)))./actualWL;
    
    WLMatrix = [WLMatrix, WLPer(:,1),actualWL, errorM, dTVTeams(:,2)];

    sortrows(WLMatrix, 1);

    errorAVG = mean(errorM);
    accuracy = [accuracy;1 - errorAVG];
end

% Figures
figure
plot(accuracy)
mean(accuracy)