function arduino = estab_arduino_connection(COM_PORT) 

%% Establish connection to arduino

wait = waitbar(0,'Establish Connection to Arduino');
arduino = serial(COM_PORT);
set(arduino,'BaudRate',115200);
set(arduino,'DataTerminalReady','off');
set(arduino,'RequestToSend','off');
set(arduino,'InputBufferSize',8);
set(arduino,'OutputBufferSize',8);
fopen(arduino);
close(wait);
wait = waitbar(1,'Connection Established');
close(wait);
%% End


% fwrite(a.aser,[54 97+pin 48+1],'uchar'); < example of sending data

end