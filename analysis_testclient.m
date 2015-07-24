clear all;
close all;
clc;

%Acquire image file
vid = videoinput('winvideo', 1);
set(vid, 'ReturnedColorSpace', 'RGB');
rgb = getsnapshot(vid);

% rgb = imread('C:\Users\john\Desktop\image data\matlab image\realimage.jpg');

subplot(2,2,1),imshow(rgb), title('\bfOriginal Image'); %1
% Remove the sky above the horizon
% sea_rgb = imcrop(rgb, [10, 50, 620, 325]);
sea_rgb = rgb;
sea_gray = rgb2gray(sea_rgb);
subplot(2,2,2), imshow(sea_gray), title('\bfSky Removed'); %2
% Simplify image

blockproc_img = analysis.blockproc_image(sea_gray);
subplot(2,2,3),imshow(blockproc_img), title('\bfSimplified blocked version'); %3
steps = analysis.count_steps(blockproc_img);
%imwrite(blockproc_img,'C:\Users\john\Desktop\image data\matlab image\outputimage.png');
%disp('Image succefully written'); 
[tide_level, danger_level] = analysis.tidal_status(steps);

message = sprintf('Steps = %d, tide = %s, danger = %s', steps, ...
          tide_level, danger_level);

disp(message);
      
disp('Using hypothetical image of dangerous level');



danger_img = imread('C:\Users\john\Desktop\image data\matlab image\outputimage.png');
steps_danger = analysis.count_steps(danger_img);
[tide_danger, danger_level_danger] = analysis.tidal_status(steps_danger);
message_danger = sprintf('Steps = %d, tide = %s, danger = %s', steps_danger, ...
          tide_danger, danger_level_danger);

subplot(2,2,4), imshow(danger_img),title('\bfHigh Tide/Dangerous Level');      %4
disp(message_danger);





