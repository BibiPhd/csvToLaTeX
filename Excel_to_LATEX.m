
%% MATLAB script that converts CSV (Comma-Separated Values) data into LaTeX tables in .txt format. 
% If you are working on a document or publication that requires converting a big table, this tool simplifies the process.

%% HOW TO USE

% 1. Clone or download this repository.
% 2. Place your CSV file in the designated directory.
% 3. Run the MATLAB script.
% 4. Retrieve the generated LaTeX code for your tables.
% 5. Customize the LaTeX code as needed for your documents.

%% Input and output file paths
inputFile = 'input.csv';
outputFile = 'output.txt';

% Read the CSV file into a MATLAB table
data = readtable(inputFile);

% Get the number of rows and columns in the table
numRows = size(data, 1);
numCols = size(data, 2);

% Open the output LaTeX file for writing
fid = fopen(outputFile, 'w');

% Start writing the LaTeX document
fprintf(fid, '\\documentclass{article}\n');
fprintf(fid, '\\begin{document}\n\n');

% Begin the LaTeX table environment
fprintf(fid, '\\begin{table}[h]\n');
fprintf(fid, '\\centering\n');
fprintf(fid, '\\begin{tabular}{');

% Create the table column format (e.g., 'ccc' for three centered columns)
columnFormat = repmat('c', 1, numCols);
fprintf(fid, '%s}\n', columnFormat);

% Write the table headers
fprintf(fid, '\\hline\n');
for col = 1:numCols
    fprintf(fid, '%s', data.Properties.VariableNames{col});
    if col < numCols
        fprintf(fid, ' & ');
    else
        fprintf(fid, ' \\\\\n');
    end
end
fprintf(fid, '\\hline\n');

% Write the table data
for row = 1:numRows
    for col = 1:numCols
        % Convert cell contents to strings before printing
        cellContent = data{row, col};
        if isnumeric(cellContent)
            fprintf(fid, '%.2f', cellContent);
        else
            fprintf(fid, '%s', char(cellContent));
        end
        if col < numCols
            fprintf(fid, ' & ');
        else
            fprintf(fid, ' \\\\\n');
        end
    end
end

% End the LaTeX table and document
fprintf(fid, '\\hline\n');
fprintf(fid, '\\end{tabular}\n');
fprintf(fid, '\\end{table}\n\n');
fprintf(fid, '\\end{document}\n');

% Close the LaTeX file
fclose(fid);

% Inform the user about the completion
fprintf('LaTeX table generated successfully in %s\n', outputFile);

