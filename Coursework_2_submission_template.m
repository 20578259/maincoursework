% dawood azab
% egyda6@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

% Insert answers here

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% Setup and data acquisition
d = 600; % Duration in seconds
time = linspace(0, d, d + 1); % Time array from 0 to 600 seconds
temperaturedata = zeros(1, d + 1); % Initialize temperature data array
a= arduino('COM3', 'Uno');
tempsensorPin= 'A0' ;
T_c = 0.01; % Temperature coefficient 
V_0 = 0.5; % Zero-degree voltage 

for i = 1:length(time)
    voltage = readVoltage(a, 'A0'); % Read voltage from sensor
    Temp_data(i) = (voltage - V_0) / T_c; % Convert voltage to temperature
    pause(1); % Pause for 1 second
end

temp_min = min(Temp_data);
temp_max = max(Temp_data);
avg_temp = mean(Temp_data);

%  Plotting
figure;
plot(time, Temp_data);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature vs. Time');

% display the filled box
fprintf('Data logging initiated - 25/4/2024\n');
fprintf('Location - Nottingham\n\n');

for i = 0:10
    fprintf('Minute\t\t%d\n', i);
    fprintf('Temperature\t%.2f C\n\n', Temp_data(i * 60 + 1));
end

fprintf('Max temp\t%.2f C\n', temp_max);
fprintf('Min temp\t%.2f C\n', temp_min);
fprintf('Average temp\t%.2f C\n', avg_temp);
fprintf('Data logging terminated\n');

% file
fileID = fopen('cabin_temperature.txt', 'w');
fprintf(fileID, 'Data logging initiated - 5/3/2024\n');
fprintf(fileID, 'Location - Nottingham\n\n');

for i = 0:10
    fprintf(fileID, 'Minute\t\t%d\n', i);
    fprintf(fileID, 'Temperature\t%.2f C\n\n', Temp_data(i * 60 + 1));
end

fprintf(fileID, 'Max temp\t%.2f C\n', temp_max);
fprintf(fileID, 'Min temp\t%.2f C\n', temp_min);
fprintf(fileID, 'Average temp\t%.2f C\n', avg_temp);
fprintf(fileID, 'Data logging terminated\n');
fclose(fileID);

% Check the file content
fileID = fopen('cabin_temperature.txt', 'r');
fileContent = fread(fileID, '*char')';
fclose(fileID);
disp(fileContent);

% Insert answers here

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

a = arduino('COM3', 'Uno');
    % Temperature sensor pin
    tempsensorPin = 'A0';
time = 0
temperature = 0;
 figure;
 plot(time,temperature,"*");
 xlabel('Time')
 ylabel('Temperature')
 title('temp menitoring by time')
 hold on ;
 grid on;
    for x = 1:inf
    voltage = readVoltage(a, tempsensorPin);
    [temperature] = temp_monitor (a,voltage);
    % Setup LED pins
    greenLED = 'D9';
    yellowLED = 'D10';
    redLED = 'D11';
    
  % Setup figure for live plotting
    plot(time,temperature, "*")
    time = time + 1;
    pause(1);
    
    end

%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% MATLAB Script to Run temp_prediction Function

% This script initializes the necessary parameters and then calls the
% temp_prediction function, which monitors and calculates temperature
% changes using an Arduino board.

% Display starting message
disp('Starting the temperature monitoring system...');

try
    % Call the temperature prediction function
    % The function temp_prediction is assumed to be defined in another file
    % as provided in the user's description.
    temp_prediction();
catch ME
    % Error handling to catch any issues that occur during the function execution
    disp('An error occurred while running the temperature monitoring system:');
    disp(ME.message);
end

% Display ending message
disp('Temperature monitoring system has stopped.');






%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

%As it developed, this initiative offered a number of strengths and challenges. Making sure the temperature was accurately measured and predicted using the Arduino and temperature sensor was one of the biggest problems. Significant challenges that necessitated thorough thought and testing were calibrating the sensor and taking noise in the readings into consideration. The implementation of the logic to regulate the LEDs in accordance with the pace of temperature change presented another difficulty. Iterative modifications were necessary to ensure smooth transitions between varied temperature change rates and to balance the time of LED activation.
% In spite of these difficulties, the project had a number of positive aspects. Continuous temperature monitoring and future value prediction provide insightful information about the state of the environment that could be used for a number of applications, such as aerospace temperature monitoring.
%The project also showed how well MATLAB and Arduino hardware could be integrated, demonstrating the flexibility and strength of these tools for real-time data collection and control systems.
% There are, however, some restrictions to take into account. External factors like ambient temperature variations and sensor calibration drift over time might impact the accuracy of temperature prediction. Furthermore, the current implementation lacks reliable fault tolerance and error handling capabilities, which could cause unexpected behaviour in practical situations.
%In order to make the project better in the future, a few improvements might be taken into account. The system's dependability would increase with the use of sophisticated filtering techniques to lower noise in temperature measurements and the improvement of the prediction algorithm for increased precision. The system's performance might be further enhanced by adding feedback systems to dynamically modify LED control thresholds in response to external factors.
% All things considered, this project offered insightful knowledge on temperature monitoring and control systems that make use of Arduino and MATLAB. By addressing the obstacles faced and capitalising on the project's advantages, future improvements and applications in environments with temperature sensitivity will be made possible.

