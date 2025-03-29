# hoohacks_2025

Pipeline: Reads Adafruit IMU sensor data and writes acceleration and gyroscope data live to serial monitor. CoolTerm app then reads 
the IMU data and writes it to an output text file live as well. Python script then reads the CoolTerm output file after it updates every 10 seconds and writes the cleaned data to a text file that Godot will then read from. 