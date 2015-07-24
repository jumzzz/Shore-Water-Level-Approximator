clear all;
close all;
clc;


comport_list = get_available_comport();
disp(comport_list(1));

disp(iscellstr(comport_list(1,1)));
disp(isstr(comport_list{1}));
disp(length(comport_list));



fileID = fopen('D:\Matlab\Matlab 2012a\bin\Image Processing\Tidal State Recognition System\Port Connection\com_port.txt','w');

 for i = 1:length(comport_list)
    
     fprintf(fileID,'%s\n',comport_list{i});
     
 end
 
fclose(fileID);


fileID = fopen('D:\Matlab\Matlab 2012a\bin\Image Processing\Tidal State Recognition System\Port Connection\com_port.txt','r');


com_list = textscan(fileID,'%s');

disp(com_list{1});
 
fclose(fileID);

