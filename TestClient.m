clear all;
close all;

clc;


% processing image
rgb_orig = imread('C:\Users\john\Desktop\image data\matlab image\realimage.jpg');

sea_img = analysis.crop_sea(rgb_orig);

imshow(rgb_orig);

I_sea = rgb2gray(sea_img);
figure, imshow(I_sea);

K = rangefilt(I_sea);

figure, imshow(K), title('\bfUnfiltered');


myfun = @(block_struct)...
      uint8(mean2(block_struct.data)*...
      ones(size(block_struct.data)));
I2 = blockproc(K, [4 620], myfun);
figure, imshow(I2,[]);

[m, n] = size(I2);
message = sprintf('m = %d, n = %d',m,n);
disp(message);

intensity = 0;

x = 310;
y = 1;

while intensity <= 30

    temp = impixel(I2, x, y);
    
    intensity = temp(1);
    
    intensity_msg = sprintf('Intensity @ (%d,%d) = %d',x,y,intensity);
    disp(intensity_msg);
    
    if intensity <= 30
        y = y + 1;
    
    end
    
    
end


step = y;

if step < 185
    condition = 'LOW';
    danger = 'SAFE';
    
elseif step >= 185 && step < 210
    condition = 'HIGH';
    danger = 'SAFE';
    
elseif step >= 210
    condition = 'HIGH';
    danger = 'DANGEROUS';
    
end



message_step = sprintf('Number of steps = %d, Tide = %s,State = %s',step, condition, danger);
disp(message_step)

