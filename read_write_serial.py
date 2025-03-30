#sanitizes and writes the live arduino imu serial data read from the text file that CoolTerm writes to approximately every 10 seconds
import time
import re
import os
path = "imu_points.txt"
output = "hoohacks_2025/render_project/input.txt"

valid_line_regex = r'^-?\d+(\.\d+)?,-?\d+(\.\d+)?,-?\d+(\.\d+)?$'

def is_valid_line(line):
    # Check if the line matches the expected format of three floats separated by commas
    return re.match(valid_line_regex, line.strip()) is not None

input_file_path = 'input.txt'
output_file_path = 'cleaned_imu_points.txt'
with open(path, 'rb') as file:
    data = file.read()
cleaned_data = data.decode('utf-8', errors='ignore')
with open(output_file_path, 'w') as output_file:
    output_file.write(cleaned_data)

def read_new_data(file_path):
    line_number = 0
    while True:
        with open(file_path, 'r') as file:
            lines = file.readlines()
            if len(lines) > line_number:
                new_lines = lines[line_number:]
                cleaned_lines = [line.strip() for line in new_lines]
                line_number = len(lines)
                if not os.path.exists(output):
                    with open(output, 'w'):  # Creates the file if it doesn't exist
                        pass
                with open(output, "w") as output_file:
                    for line in cleaned_lines:
                        if is_valid_line(line):
                            output_file.write(line + "\n")
        time.sleep(10)

read_new_data(output_file_path)





