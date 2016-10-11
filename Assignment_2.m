% 2. histograms for low gain and high gain photos

high_gain_photos = dir('High Gain Photos');
low_gain_photos = dir('Low Gain Photos');
high_gain_pixel_vals = zeros(50,0);
low_gain_pixel_vals = zeros(50,0);

% for i = 3:numel(high_gain_photos) % starts at 3 because first 2 values are '.' and '..'
%     filename = getfield(high_gain_photos, {i}, 'name'); % gets file name of each image
%     image1 = imread(filename);
%     high_gain_pixel_vals(i-2) = image1(500,1000); % appends pixel value to vector
% end
% 
% for i = 3:numel(low_gain_photos) 
%     filename = getfield(low_gain_photos, {i}, 'name'); 
%     image2 = imread(filename); 
%     low_gain_pixel_vals(i-2) = image2(500,1000); 
% end
% 
% figure('Name','High Gain Pixel Values','NumberTitle','off')
% hist(high_gain_pixel_vals)
% 
% figure('Name','Low Gain Pixel Values','NumberTitle','off')
% hist(low_gain_pixel_vals)


% 3. Mean and variance of pixels

% High Gain
mean_array = zeros(1944,2592);
variance_array = zeros(1944,2592);
for ii=1:1944
    for jj=1:2592
        val = 0;
        running_variance = zeros(numel(high_gain_photos)-2,0);
        % get pixel value
        for pic = 3:numel(high_gain_photos)
            filename = getfield(high_gain_photos, {pic}, 'name'); 
            image = imread(filename);
            val = val + image(ii,jj);
            running_variance(pic-2) = image(ii,jj);  
        end
        mean = val/50;
        mean_array(ii,jj) = mean;
        variance_array(ii,jj) = var(running_variance);
    end
end
    
figure('Name','High Gain Mean Pixel Values','NumberTitle','off')
image(mean_array)

figure('Name','High Gain Variance Pixel Values','NumberTitle','off')
image(variance_array)

% Low Gain

mean_array_low = zeros(1944,2592);
variance_array_low = zeros(1944,2592);
for ii=1:1944
    for jj=1:2592
        val = 0;
        running_variance_low = zeros(numel(high_gain_photos)-2,0);
        % get pixel value
        for pic = 3:numel(low_gain_photos)
            filename = getfield(low_gain_photos, {pic}, 'name'); 
            image = imread(filename);
            val = val + image(ii,jj);
            running_variance_low(pic-2) = image(ii,jj);  
        end
        mean = val/50;
        mean_array_low(ii,jj) = mean;
        variance_array_low(ii,jj) = var(running_variance_low);
    end
end
    
figure('Name','Low Gain Mean Pixel Values','NumberTitle','off')
image(mean_array_low)

figure('Name','Low Gain Variance Pixel Values','NumberTitle','off')
image(variance_array_low)


% 4. Variance as function of mean

rounded_means_high = round(mean_array,0);
rounded_mean_low = round(mean_array_low,0);



figure('Name','High Gain Variance vs Mean','NumberTitle','off')
plot(rounded_means_high, variance_array)

figure('Name','Low Gain Variance vs Mean','NumberTitle','off')
plot(rounded_means_low, variance_array_low)

%5. Fit line

%High Gain
p = polyfit(rounded_means_high, variance_array, 1);
x1 = rounded_means_high;
y1 = polyval(p, rounded_means_high);
plot(rounded_means_high, variance_array, 'o')
hold on
plot(x1, y1);
hold off

%Low Gain
p = polyfit(rounded_means_low, variance_array_low, 1);
x1 = rounded_means_low;
y1 = polyval(p, rounded_means_low);
plot(rounded_means_low, variance_array_low, 'o')
hold on
plot(x1, y1);
hold off

%6. 


    
