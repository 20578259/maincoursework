
function temp_monitor(a)
    % temp_monitor - Monitors temperature and controls LEDs accordingly
    % This function continuously monitors the temperature using an Arduino
    % connected sensor and controls three LEDs (green, yellow, red) based on
    % the temperature value. Green LED lights up for temperatures between 18-24°C,
    % yellow blinks below 18°C, and red blinks above 24°C.

    a = arduino('COM3', 'Uno');
    % Define Arduino pins for LEDs
    greenLED = 'D9';
    yellowLED = 'D10';
    redLED = 'D11';

    % Setup LED pins
    configurePin(a, greenLED, 'DigitalOutput');
    configurePin(a, yellowLED, 'DigitalOutput');
    configurePin(a, redLED, 'DigitalOutput');

    % Temperature sensor pin
    tempSensorPin = 'A0';

    % Setup figure for live plotting
    figure;
    h = animatedline;
    xlabel('Time (s)');
    ylabel('Temperature (°C)');
    grid on;

    startTime = datetime('now');
    
    while true
        % Read temperature from sensor
        voltage = readVoltage(a, tempSensorPin);
        temperature = (voltage - 0.5) * 100; % Convert voltage to temperature

        % Add point to live graph
        t =  datetime('now') - startTime;
        addpoints(h, datenum(t), temperature);
        datetick('x','keeplimits');
        drawnow;

        % Control LEDs based on temperature
        if temperature >= 18 && temperature <= 24
            writeDigitalPin(a, greenLED, 1);
            writeDigitalPin(a, yellowLED, 0);
            writeDigitalPin(a, redLED, 0);
        elseif temperature < 18
            writeDigitalPin(a, greenLED, 0);
            blinkLED(a, yellowLED, 0.5);
            writeDigitalPin(a, redLED, 0);
        else
            writeDigitalPin(a, greenLED, 0);
            writeDigitalPin(a, yellowLED, 0);
            blinkLED(a, redLED, 0.25);
        end

        pause(1); % Pause for 1 second before next reading
    end
end

function blinkLED(a, pin, interval)
    writeDigitalPin(a, pin, 1);
    pause(interval / 2);
    writeDigitalPin(a, pin, 0);
    pause(interval / 2);
end