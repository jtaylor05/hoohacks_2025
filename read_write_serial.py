#sanitizes and writes the live arduino imu serial data read from the text file that CoolTerm writes to approximately every 10 seconds
import time
path = "testmaia.txt"
output = "output.txt"

def read_new_data(file_path):
    line_number = 0
    while True:
        with open(file_path, 'r') as file:
            lines = file.readlines()
            if len(lines) > line_number:
                new_lines = lines[line_number:]
                cleaned_lines = [line.strip() for line in new_lines]
                line_number = len(lines)
                with open(output, "w") as output_file:
                    for line in cleaned_lines:
                        output_file.write(line+"\n")
        time.sleep(5)

read_new_data(path)





