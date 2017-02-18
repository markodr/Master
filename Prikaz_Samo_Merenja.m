clear all
close all
clc
filename = 'C:\Users\Embedded Design\Desktop\LabView Master\Cisto_merenje_3_ACC.lvm';
delimiter = '\t';
startRow = 24;
formatSpec = '%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
for col=[2,3,4,5,6,7]
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
rawNumericColumns = raw(:, [2,3,4,5,6,7]);
rawCellColumns = raw(:, [1,8]);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells
X_Value = rawCellColumns(:, 1);
Zuta1 = cell2mat(rawNumericColumns(:, 1));
Zelena1 = cell2mat(rawNumericColumns(:, 2));
Zuta2 = cell2mat(rawNumericColumns(:, 3));
Zelena2 = cell2mat(rawNumericColumns(:, 4));
Zuta3 = cell2mat(rawNumericColumns(:, 5));
Zelena3 = cell2mat(rawNumericColumns(:, 6));
Comment = rawCellColumns(:, 2);
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;

%% ACC 1
figure('name','Senzor 1');
title('ACC 1 - Gornji Senzor');
hold on;
N_Zelena1=Zelena1-mean(Zelena1);
plot(N_Zelena1,'g');
N_Zuta1=Zuta1-mean(Zuta1);
plot(N_Zuta1,'y');
hold off;
fprintf('\nSenzor 1      %f   %f',sum(N_Zelena1.^2),sum(N_Zuta1.^2));
legend(num2str(sum(N_Zelena1.^2)),num2str(sum(N_Zuta1.^2)));

%% ACC 2
figure('name','Senzor 2');
title('ACC 2 - Srednji Senzor');
hold on;
N_Zelena2=Zelena2-mean(Zelena2);
plot(N_Zelena2,'g');
N_Zuta2=Zuta2-mean(Zuta2);
plot(N_Zuta2,'y');
hold off;
fprintf('\nSenzor 2      %f   %f',sum(N_Zelena2.^2),sum(N_Zuta2.^2));
legend(num2str(sum(N_Zelena2.^2)),num2str(sum(N_Zuta2.^2)));

%% ACC 3
figure('name','Senzor 3');
title('ACC 3 - Donji Senzor');
hold on;
N_Zelena3=Zelena3-mean(Zelena3);
plot(N_Zelena3,'g');
N_Zuta3=Zuta3-mean(Zuta3);
plot(N_Zuta3,'y');
hold off;
fprintf('\nSenzor 3      %f   %f',sum(N_Zelena3.^2),sum(N_Zuta3.^2));
legend(num2str(sum(N_Zelena3.^2)),num2str(sum(N_Zuta3.^2)));

%% PRIKAZIVANJE inteziteta
figure('name','Inteziteti');
title('Inteziteti - Svi ACC');
hold on;
Intezitet_1= N_Zelena1.^2 + N_Zuta1.^2 ;
plot(Intezitet_1,'y')
Intezitet_2= N_Zelena2.^2 + N_Zuta2.^2 ;
plot(Intezitet_2,'b')
Intezitet_3= N_Zelena3.^2 + N_Zuta3.^2 ;
plot(Intezitet_3,'g')
hold off;
legend('ACC 1','ACC 2','ACC 3');

fprintf('\n')

% % 
% % %% Prikazivanje osa
% % 
% % figure('name','ose');
% % title('ose - Svi ACC');
% % hold on;
% % plot(N_Bela1);
% % plot(N_Bela2);
% % %plot(N_Bela3);
% % hold off;
% % fprintf('\n')

% % % %% ODBACUJEM PRHIH PAR MERENJA
% % % pocetak=2;
% % % 
% % % tmp=Zuta1(pocetak :length(Zuta1));
% % % clear Zuta1; Zuta1=tmp; clear tmp;
% % % tmp=Zuta2(pocetak :length(Zuta2));
% % % clear Zuta2; Zuta2=tmp; clear tmp;
% % % tmp=Zuta3(pocetak :length(Zuta3));
% % % clear Zuta3; Zuta3=tmp; clear tmp;
% % % 
% % % tmp=Zelena1(pocetak :length(Zelena1));
% % % clear Zelena1; Zelena1=tmp; clear tmp;
% % % tmp=Zelena2(pocetak :length(Zelena2));
% % % clear Zelena2; Zelena2=tmp; clear tmp;
% % % tmp=Zelena3(pocetak :length(Zelena3));
% % % clear Zelena3; Zelena3=tmp; clear tmp;