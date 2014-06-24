function [left_eye_center_x,left_eye_center_y,right_eye_center_x,right_eye_center_y,left_eye_inner_corner_x,left_eye_inner_corner_y,left_eye_outer_corner_x,left_eye_outer_corner_y,right_eye_inner_corner_x,right_eye_inner_corner_y,right_eye_outer_corner_x,right_eye_outer_corner_y,left_eyebrow_inner_end_x,left_eyebrow_inner_end_y,left_eyebrow_outer_end_x,left_eyebrow_outer_end_y,right_eyebrow_inner_end_x,right_eyebrow_inner_end_y,right_eyebrow_outer_end_x,right_eyebrow_outer_end_y,nose_tip_x1,nose_tip_y1,mouth_left_corner_x,mouth_left_corner_y,mouth_right_corner_x,mouth_right_corner_y,mouth_center_top_lip_x,mouth_center_top_lip_y,mouth_center_bottom_lip_x,mouth_center_bottom_lip_y,Image1] = importfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [LEFT_EYE_CENTER_X,LEFT_EYE_CENTER_Y,RIGHT_EYE_CENTER_X,RIGHT_EYE_CENTER_Y,LEFT_EYE_INNER_CORNER_X,LEFT_EYE_INNER_CORNER_Y,LEFT_EYE_OUTER_CORNER_X,LEFT_EYE_OUTER_CORNER_Y,RIGHT_EYE_INNER_CORNER_X,RIGHT_EYE_INNER_CORNER_Y,RIGHT_EYE_OUTER_CORNER_X,RIGHT_EYE_OUTER_CORNER_Y,LEFT_EYEBROW_INNER_END_X,LEFT_EYEBROW_INNER_END_Y,LEFT_EYEBROW_OUTER_END_X,LEFT_EYEBROW_OUTER_END_Y,RIGHT_EYEBROW_INNER_END_X,RIGHT_EYEBROW_INNER_END_Y,RIGHT_EYEBROW_OUTER_END_X,RIGHT_EYEBROW_OUTER_END_Y,NOSE_TIP_X1,NOSE_TIP_Y1,MOUTH_LEFT_CORNER_X,MOUTH_LEFT_CORNER_Y,MOUTH_RIGHT_CORNER_X,MOUTH_RIGHT_CORNER_Y,MOUTH_CENTER_TOP_LIP_X,MOUTH_CENTER_TOP_LIP_Y,MOUTH_CENTER_BOTTOM_LIP_X,MOUTH_CENTER_BOTTOM_LIP_Y,IMAGE1]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [LEFT_EYE_CENTER_X,LEFT_EYE_CENTER_Y,RIGHT_EYE_CENTER_X,RIGHT_EYE_CENTER_Y,LEFT_EYE_INNER_CORNER_X,LEFT_EYE_INNER_CORNER_Y,LEFT_EYE_OUTER_CORNER_X,LEFT_EYE_OUTER_CORNER_Y,RIGHT_EYE_INNER_CORNER_X,RIGHT_EYE_INNER_CORNER_Y,RIGHT_EYE_OUTER_CORNER_X,RIGHT_EYE_OUTER_CORNER_Y,LEFT_EYEBROW_INNER_END_X,LEFT_EYEBROW_INNER_END_Y,LEFT_EYEBROW_OUTER_END_X,LEFT_EYEBROW_OUTER_END_Y,RIGHT_EYEBROW_INNER_END_X,RIGHT_EYEBROW_INNER_END_Y,RIGHT_EYEBROW_OUTER_END_X,RIGHT_EYEBROW_OUTER_END_Y,NOSE_TIP_X1,NOSE_TIP_Y1,MOUTH_LEFT_CORNER_X,MOUTH_LEFT_CORNER_Y,MOUTH_RIGHT_CORNER_X,MOUTH_RIGHT_CORNER_Y,MOUTH_CENTER_TOP_LIP_X,MOUTH_CENTER_TOP_LIP_Y,MOUTH_CENTER_BOTTOM_LIP_X,MOUTH_CENTER_BOTTOM_LIP_Y,IMAGE1]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [left_eye_center_x,left_eye_center_y,right_eye_center_x,right_eye_center_y,left_eye_inner_corner_x,left_eye_inner_corner_y,left_eye_outer_corner_x,left_eye_outer_corner_y,right_eye_inner_corner_x,right_eye_inner_corner_y,right_eye_outer_corner_x,right_eye_outer_corner_y,left_eyebrow_inner_end_x,left_eyebrow_inner_end_y,left_eyebrow_outer_end_x,left_eyebrow_outer_end_y,right_eyebrow_inner_end_x,right_eyebrow_inner_end_y,right_eyebrow_outer_end_x,right_eyebrow_outer_end_y,nose_tip_x1,nose_tip_y1,mouth_left_corner_x,mouth_left_corner_y,mouth_right_corner_x,mouth_right_corner_y,mouth_center_top_lip_x,mouth_center_top_lip_y,mouth_center_bottom_lip_x,mouth_center_bottom_lip_y,Image1]
%   = importfile('training.csv',1, 7050);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2014/06/11 21:10:30

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
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

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]);
rawCellColumns = raw(:, 31);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Allocate imported array to column variable names
left_eye_center_x = cell2mat(rawNumericColumns(:, 1));
left_eye_center_y = cell2mat(rawNumericColumns(:, 2));
right_eye_center_x = cell2mat(rawNumericColumns(:, 3));
right_eye_center_y = cell2mat(rawNumericColumns(:, 4));
left_eye_inner_corner_x = cell2mat(rawNumericColumns(:, 5));
left_eye_inner_corner_y = cell2mat(rawNumericColumns(:, 6));
left_eye_outer_corner_x = cell2mat(rawNumericColumns(:, 7));
left_eye_outer_corner_y = cell2mat(rawNumericColumns(:, 8));
right_eye_inner_corner_x = cell2mat(rawNumericColumns(:, 9));
right_eye_inner_corner_y = cell2mat(rawNumericColumns(:, 10));
right_eye_outer_corner_x = cell2mat(rawNumericColumns(:, 11));
right_eye_outer_corner_y = cell2mat(rawNumericColumns(:, 12));
left_eyebrow_inner_end_x = cell2mat(rawNumericColumns(:, 13));
left_eyebrow_inner_end_y = cell2mat(rawNumericColumns(:, 14));
left_eyebrow_outer_end_x = cell2mat(rawNumericColumns(:, 15));
left_eyebrow_outer_end_y = cell2mat(rawNumericColumns(:, 16));
right_eyebrow_inner_end_x = cell2mat(rawNumericColumns(:, 17));
right_eyebrow_inner_end_y = cell2mat(rawNumericColumns(:, 18));
right_eyebrow_outer_end_x = cell2mat(rawNumericColumns(:, 19));
right_eyebrow_outer_end_y = cell2mat(rawNumericColumns(:, 20));
nose_tip_x1 = cell2mat(rawNumericColumns(:, 21));
nose_tip_y1 = cell2mat(rawNumericColumns(:, 22));
mouth_left_corner_x = cell2mat(rawNumericColumns(:, 23));
mouth_left_corner_y = cell2mat(rawNumericColumns(:, 24));
mouth_right_corner_x = cell2mat(rawNumericColumns(:, 25));
mouth_right_corner_y = cell2mat(rawNumericColumns(:, 26));
mouth_center_top_lip_x = cell2mat(rawNumericColumns(:, 27));
mouth_center_top_lip_y = cell2mat(rawNumericColumns(:, 28));
mouth_center_bottom_lip_x = cell2mat(rawNumericColumns(:, 29));
mouth_center_bottom_lip_y = cell2mat(rawNumericColumns(:, 30));
Image1 = rawCellColumns(:, 1);
