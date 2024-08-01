wave_start = 1540;
wave_stop = 1600;
wave_step = 0.1;
step_delay = 0.2;
% wave_start = 1305;
% wave_stop = 1307;
% wave_step = 0.001;
% step_delay = 0.05;

filename='2x2mzi2_a2';
step_num = (wave_stop - wave_start) / wave_step;
wl_array=[];
pow_array=[];
str_SetWave = 'source:wavelength' ;
str_GetPow_thorlabs = 'READ?' ;


try
    for ii=0:step_num
        wave_current = wave_start + ii .* wave_step;
        fprintf(com_obj, [str_SetWave,' ',num2str(wave_current)]);
        pause(step_delay)

        meter.updateReading(0.0001);  % Update reading with a 0.001 second interval

        pause(0.001)

        pow_array(end+1)=10*log10(meter.meterPowerReading*1e3); %unit: dBm

        wl_array(end+1)=wave_current;
        figure(1)
        plot(wl_array,pow_array);
    end
    fprintf(com_obj,'source:wavelength 1550');
    dlmwrite(strcat(filename,'.txt'),[wl_array'  pow_array'], 'delimiter','\t','newline','pc', 'precision', '%.6e')
    save(strcat(filename,'.mat'));
    saveas(gcf,[filename,'.fig']);
    saveas(gcf,[filename,'.tif']);
end

% close all
 [row,col]=find(pow_array==max(pow_array))
wl_array(col)