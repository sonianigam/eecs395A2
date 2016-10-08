high_gain_photos = dir('High Gain Photos');
low_gain_photos = dir('Low Gain Photos');
high_gain_pixel_vals = [];
low_gain_pixel_vals = [];
for i = 1:numel(high_gain_photos)
    image = imread(i);
    high_gain_pixel_vals[i] = image(500,1000);
    



% 
% t = Tiff('1.dng','r');
% im = read(t);

im = imread('1.dng');