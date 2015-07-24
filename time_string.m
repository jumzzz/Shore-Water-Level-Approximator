function timedisplay = time_string()
    x = clock;
    if(x(4) > 12)
       hour_time = mod(x(4),12); 
       meridian = ' PM';
    else
       hour_time = x(4);
       meridian = ' AM';
    end
    timedisplay = strcat(sprintf('%.2d',hour_time),':',sprintf('%.2d',x(5)),':',sprintf('%.2d',floor(x(6))),meridian);
    
end