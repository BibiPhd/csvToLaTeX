import pandas as pd

# Input and output file paths
input_file = 'input.csv'
output_file = 'output.tex'

# Read the CSV file into a pandas DataFrame
data = pd.read_csv(input_file)

# Get the number of rows and columns in the DataFrame
num_rows, num_cols = data.shape

# Open the output LaTeX file for writing
with open(output_file, 'w') as f:
    # Start writing the LaTeX document
    f.write('\\documentclass{article}\n')
    f.write('\\begin{document}\n\n')

    # Begin the LaTeX table environment
    f.write('\\begin{table}[h]\n')
    f.write('\\centering\n')
    f.write('\\begin{tabular}{')

    # Create the table column format (e.g., 'ccc' for three centered columns)
    column_format = 'c' * num_cols
    f.write('%s}\n' % column_format)

    # Write the table headers
    f.write('\\hline\n')
    f.write(' & '.join(data.columns) + ' \\\\\n')
    f.write('\\hline\n')

    # Write the table data
    for _, row in data.iterrows():
        for col in range(num_cols):
            # Convert cell contents to strings before printing
            cell_content = row[col]
            if pd.api.types.is_numeric_dtype(cell_content):
                f.write(f'{cell_content:.2f}')
            else:
                f.write(str(cell_content))
            if col < num_cols - 1:
                f.write(' & ')
            else:
                f.write(' \\\\\n')

    # End the LaTeX table and document
    f.write('\\hline\n')
    f.write('\\end{tabular}\n')
    f.write('\\end{table}\n\n')
    f.write('\\end{document}\n')

# Inform the user about the completion
print(f'LaTeX table generated successfully in {output_file}')
