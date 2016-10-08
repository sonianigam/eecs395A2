% 2. histograms for low gain and high gain photos

high_gain_photos = dir('High Gain Photos');
low_gain_photos = dir('Low Gain Photos');
high_gain_pixel_vals = zeros(50,0);
low_gain_pixel_vals = zeros(50,0);

for i = 3:numel(high_gain_photos) % starts at 3 because first 2 values are '.' and '..'
    filename = getfield(high_gain_photos, {i}, 'name'); % gets file name of each image
    image1 = imread(filename);
    high_gain_pixel_vals(i-2) = image1(500,1000); % appends pixel value to vector
end

for i = 3:numel(low_gain_photos) 
    filename = getfield(low_gain_photos, {i}, 'name'); 
    image2 = imread(filename); 
    low_gain_pixel_vals(i-2) = image2(500,1000); 
end

figure('Name','High Gain Pixel Values','NumberTitle','off')
hist(high_gain_pixel_vals)

figure('Name','Low Gain Pixel Values','NumberTitle','off')
hist(low_gain_pixel_vals)


% 3. Mean and variance of pixels


%



    
