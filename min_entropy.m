classdef min_entropy
    
    methods(Static)
        
        function sea_img = crop_sea(img)
              sea_img = imcrop(img, [10, 160, 620, 190]); 
        end
        
        function min = find_min(img)
             
            sea_img = min_entropy.crop_sea(img);
            sea_img_gr = rgb2gray(sea_img);
            
            [width, height] = size(sea_img_gr);
            
            message = sprintf('Width = %d, Height = %d', width, height);
            disp(message);
            
            imshow(sea_img_gr);
            min = entropy(sea_img_gr);
            
            for j = 0:5:(185)
               
                for i = 0:5:(10 + 610)
                   
                    
                    temp = imcrop(sea_img_gr, [i, j, 5, 5]);
                    entr = entropy(temp);
                    
                    current_ind = sprintf('x = %d, y = %d, entropy = %0.5g', i, j, entr);
                    disp(current_ind);
                    
                    if min > entr 
                 
                        min = entr;
                    end
                    
                end
                
                
            end
            
        end
        
    end
    
end