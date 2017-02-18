clear all;
close all;
clc;
filename = 'C:\Users\Embedded Design\Desktop\LabView Master\Cisto_merenje_3_ACC.lvm';
delimiter = '\t';
startRow = 24;
formatSpec = '%q%q%q%q%q%q%q%q%q%q%q%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
for col=[2,3,4,5,6,7,8,9,10]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end
rawNumericColumns = raw(:, [2,3,4,5,6,7,8,9,10]);
rawCellColumns = raw(:, [1,11]);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells
X_Value = rawCellColumns(:, 1);
Zuta1 = cell2mat(rawNumericColumns(:, 1));
Zelena1 = cell2mat(rawNumericColumns(:, 2));
Zuta2 = cell2mat(rawNumericColumns(:, 3));
Zelena2 = cell2mat(rawNumericColumns(:, 4));
Zuta3 = cell2mat(rawNumericColumns(:, 5));
Zelena3 = cell2mat(rawNumericColumns(:, 6));
Intezitet_1 = cell2mat(rawNumericColumns(:, 7));
Intezitet_2 = cell2mat(rawNumericColumns(:, 8));
Intezitet_3 = cell2mat(rawNumericColumns(:, 9));
Comment = rawCellColumns(:, 2);
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;

%% ACC 1
figure('name','Senzor 1');
title('NORMALIZOVANE DVE OSE ACC 1 - Gornji Senzor');
hold on;
N_Zelena1=Zelena1-mean(Zelena1);
plot(N_Zelena1,'g');
N_Zuta1=Zuta1-mean(Zuta1);
plot(N_Zuta1,'y');
hold off;
fprintf('\nSenzor 1      %f   %f',sum(N_Zelena1.^2),sum(N_Zuta1.^2));
legend(num2str(sum(N_Zelena1.^2)),num2str(sum(N_Zuta1.^2)));

% ACC 2
figure('name','Senzor 2');
title('NORMALIZOVANE DVE OSE ACC 2 - Srednji Senzor');
hold on;
N_Zelena2=Zelena2-mean(Zelena2);
plot(N_Zelena2,'g');
N_Zuta2=Zuta2-mean(Zuta2);
plot(N_Zuta2,'y');
hold off;
fprintf('\nSenzor 2      %f   %f',sum(N_Zelena2.^2),sum(N_Zuta2.^2));
legend(num2str(sum(N_Zelena2.^2)),num2str(sum(N_Zuta2.^2)));

% ACC 3
figure('name','Senzor 3');
title('NORMALIZOVANE DVE OSE ACC 3 - Donji Senzor');
hold on;
N_Zelena3=Zelena3-mean(Zelena3);
plot(N_Zelena3,'g');
N_Zuta3=Zuta3-mean(Zuta3);
plot(N_Zuta3,'y');
hold off;
fprintf('\nSenzor 3      %f   %f',sum(N_Zelena3.^2),sum(N_Zuta3.^2));
legend(num2str(sum(N_Zelena3.^2)),num2str(sum(N_Zuta3.^2)));

% OFSET
fprintf('\n');
fprintf('\nDC Senzor 1      %f   %f',mean(Zuta1),mean(Zelena1));
fprintf('\nDC Senzor 2      %f   %f',mean(Zuta2),mean(Zelena2));
fprintf('\nDC Senzor 3      %f   %f',mean(Zuta3),mean(Zelena3));
fprintf('\n');

%% PRIKAZIVANJE OSA

figure('name','TRI SENZORA');
title('Prikaz kako se menjaju ose 3 senzora');
hold on;

plot(Zuta1,'y')
plot(Zelena1,'y')

plot(Zuta2,'b')
plot(Zelena2,'b')


plot(Zuta3,'g')
plot(Zelena3,'g')

hold off;
legend('ACC 1 -Zuta','ACC 1 -Zelena'...
      ,'ACC 2 -Zuta','ACC 1 -Zelena'...
      ,'ACC 3 -Zuta','ACC 3 -Zelena');


fprintf('\n')

%% PRIKAZIVANJE inteziteta opeglati NaN
GORE=[];
for i=1:length(Intezitet_1)
    if isnan(Intezitet_1(i))
        continue;
    else
        GORE=[GORE,Intezitet_1(i)];
    end
end

SREDINA=[];
for i=1:length(Intezitet_2)
    if isnan(Intezitet_2(i))
        continue;
    else
        SREDINA=[SREDINA,Intezitet_2(i)];
    end
end

DOLE=[];
for i=1:length(Intezitet_3)
    if isnan(Intezitet_3(i))
        continue;
    else
        DOLE=[DOLE,Intezitet_3(i)];
    end
end

OBUKA=[GORE;SREDINA;DOLE];

figure('name','Inteziteti po 500 odiraka');
title('OBUKA - Sumiranih 500 odbiraka inteziteta');
hold on;
plot(GORE,'y')
plot(SREDINA,'b')
plot(DOLE,'g')
hold off;
legend('GORE - ACC 1','SREDINA - ACC 2','DOLE - ACC 3');

%%
figure('name','Inteziteti');
title('Inteziteti NISU NORMALIZOVANI - Svi ACC');
hold on;
N_Intezitet_1= N_Zuta1.*N_Zuta1 + N_Zelena1.*N_Zelena1;
N_Intezitet_2= N_Zuta2.*N_Zuta2 + N_Zelena2.*N_Zelena2;
N_Intezitet_3= N_Zuta3.*N_Zuta3 + N_Zelena3.*N_Zelena3;
plot(N_Intezitet_1,'y')
plot(N_Intezitet_2,'b')
plot(N_Intezitet_3,'g')
hold off;
legend('ACC 1','ACC 2','ACC 3');