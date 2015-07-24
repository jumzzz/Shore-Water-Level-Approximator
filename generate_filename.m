function final_name = generate_filename(path)

    
    directory = dir(path);

    num_of_files = length(directory);


    name_of_last = directory(num_of_files).name;

    disp(name_of_last);

    first_three = length(name_of_last) - 6;
    last_three = length(name_of_last) - 4;

    num_str = name_of_last(first_three:last_three);

    disp(num_str);

    extend_number = str2double(num_str) + 1;
    disp(extend_number);

    if numel(num2str(extend_number)) == 1
       str_extend = sprintf('00%d', extend_number);

    elseif numel (num2str(extend_number)) == 2
        str_extend = sprintf('0%d', extend_number);

    elseif numel(num2str(extend_number)) == 3
        str_extend = sprintf('%d', extend_number);

    end



    final_name = sprintf('img-%s.png',str_extend);

end