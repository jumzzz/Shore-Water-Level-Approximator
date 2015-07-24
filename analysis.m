classdef analysis
    
    methods(Static)
        
        function sea_img = crop_sea(img)
            
        % Parameters to be calibrated
              fileIDx0 = fopen('D:\MATLAB\bin\Image Processing\Tidal State Recognition System\calibration values\xbegin.txt','r');
              fileIDy0 = fopen('D:\MATLAB\bin\Image Processing\Tidal State Recognition System\calibration values\ybegin.txt','r');
              fileIDwidth = fopen('D:\MATLAB\bin\Image Processing\Tidal State Recognition System\calibration values\width.txt','r');
              fileIDheight = fopen('D:\MATLAB\bin\Image Processing\Tidal State Recognition System\calibration values\height.txt','r');
              
              formatSpec = '%d';
              
              x0 = fscanf(fileIDx0, formatSpec);
              y0 = fscanf(fileIDy0, formatSpec);
              width = fscanf(fileIDwidth, formatSpec);
              height = fscanf(fileIDheight, formatSpec);
              
              sea_img = imcrop(img, [x0, y0, width, height]);
              
              fclose(fileIDx0);
              fclose(fileIDy0);
              fclose(fileIDwidth);
              fclose(fileIDheight);
              
              
        end
        
        function blockproc_img = blockproc_image(sea_img_gr)
           
            K = rangefilt(sea_img_gr);

            myfun = @(block_struct)...
                    uint8(mean2(block_struct.data)*...
                    ones(size(block_struct.data)));
            
    
        % Parameters to be calibrated

            blockproc_img = blockproc(K, [4 620], myfun);
            
        end
        
        function count_steps = count_steps(blockproc_img)
            
            size_img = size(blockproc_img);
            
            x0 = floor(size_img(1)/2);
            y0 = 1;
            
            intensity = 0;
            
            i0 = x0;
            j0 = y0;
            
            i1 = x0;
            j1 = y0;
            
            
            dim = size(blockproc_img);
            
            height = dim(2);
            max_val = 1;
            
            for k = 1:height
                
                temp_max = impixel(blockproc_img, i0, k);
                
                if temp_max(1) > max_val
                   max_val = temp_max;
                end
            end
            
            while(intensity ~= max_val )
                
               temp = impixel(blockproc_img, i1, j1);
               
               intensity = temp(1);
               
               if(intensity ~= max_val)
                  j1 = j1 + 1; 
               else
                   break
               end
                
            end
            
            count_steps = j1;
            
        end
        
        function [tide_level, danger_level] = tidal_status(count_steps)
            
            fileIDlsmin = fopen('D:\MATLAB\bin\Image Processing\Tidal State Recognition System\calibration values\low_safe_min.txt','r');
            fileIDlsmax = fopen('D:\MATLAB\bin\Image Processing\Tidal State Recognition System\calibration values\low_safe_max.txt','r');
            fileIDhsmin = fopen('D:\MATLAB\bin\Image Processing\Tidal State Recognition System\calibration values\high_safe_min.txt','r');
            fileIDhsmax = fopen('D:\MATLAB\bin\Image Processing\Tidal State Recognition System\calibration values\high_safe_max.txt','r');
                         
            formatSpec = '%d';
              
            lsmin = fscanf(fileIDlsmin, formatSpec);
            lsmax = fscanf(fileIDlsmax, formatSpec);
            hsmin = fscanf(fileIDhsmin, formatSpec);
            hsmax = fscanf(fileIDhsmax, formatSpec);
            
            
            % To be calibrated
            if count_steps < lsmin
                tide_level = 'LOW';
                danger_level = 'DANGEROUS';
            
            
            elseif count_steps >= lsmin && count_steps <= lsmax
               tide_level = 'LOW';
               danger_level = 'SAFE';
            
            elseif count_steps >= hsmin && count_steps <= hsmax 
                tide_level = 'HIGH';
                danger_level = 'SAFE';
                
            elseif count_steps >= hsmax
                tide_level = 'HIGH';
                danger_level = 'DANGEROUS';
                
            end
            
            fclose(fileIDlsmin);
            fclose(fileIDlsmax);
            fclose(fileIDhsmin);
            fclose(fileIDhsmax);
            
        end
        
    end
    
end