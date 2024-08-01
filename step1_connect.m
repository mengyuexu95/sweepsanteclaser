clear all

com_obj = visa('ni','GPIB0::1::INSTR');
% usb_obj = visa('ni','USB0::0x1313::0x8078::P0040143::0::INSTR');

meter_list=ThorlabsPowerMeter;                              % Initiate the meter_list
DeviceDescription=meter_list.listdevices;               	% List available device(s)
meter=meter_list.connect(DeviceDescription);           % Connect single/the first devices
meter.setWaveLength(1550);                             % Set sensor wavelength

fopen(com_obj);
str_StateOn = 'source:power:state 1';
str_StateOff = 'source:power:state 0';
fprintf(com_obj,str_StateOn);
pause(1);

