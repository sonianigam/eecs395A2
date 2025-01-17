% 2. histograms for low gain and high gain photos

high_gain_photos = dir('High Gain Photos');
low_gain_photos = dir('Low Gain Photos');
high_gain_pixel_vals = zeros(50,1);
low_gain_pixel_vals = zeros(50,1);

for i = 3:numel(high_gain_photos) % starts at 3 because first 2 values are '.' and '..'
    filename = getfield(high_gain_photos, {i}, 'name'); % gets file name of each image
    image1 = imread(filename);
    high_gain_pixel_vals(i-2) = image1(250,700); % appends pixel value to vector
end

for i = 3:numel(low_gain_photos) 
    filename = getfield(low_gain_photos, {i}, 'name'); 
    image2 = imread(filename); 
    low_gain_pixel_vals(i-2) = image2(250,700); 
end

figure('Name','High Gain Pixel Values','NumberTitle','off')
hist(high_gain_pixel_vals)

figure('Name','Low Gain Pixel Values','NumberTitle','off')
hist(low_gain_pixel_vals)


% 3. Mean and variance of pixels

% High Gain
mean_array_high = zeros(1944,2592);
variance_array_high = zeros(1944,2592);
image_array_high = cell(50,1);

for pic = 3:numel(high_gain_photos)
    filename = getfield(high_gain_photos, {pic}, 'name'); 
    im1 = imread(filename);
    image_array_high{pic-2} = im1;
end

for ii=1:1944
    for jj=1:2592
        val = 0;
        running_variance = zeros(numel(high_gain_photos)-2,1);
        % get pixel value
        for x = 1:50
            curr_image = image_array_high{x};
            val = val + double(curr_image(ii,jj));
            running_variance(x) = double(curr_image(ii,jj));  
        end
        mymean = val/50;
        mean_array_high(ii,jj) = mymean;
        variance_array_high(ii,jj) = var(running_variance);
    end
end

variance_array_high = ceil(variance_array_high);
    
figure('Name','High Gain Mean Pixel Values','NumberTitle','off');
colormap gray
imagesc(mean_array_high)

figure('Name','High Gain Variance Pixel Values','NumberTitle','off');
colormap gray
imagesc(variance_array_high)

% Low Gain

mean_array_low = zeros(1944,2592);
variance_array_low = zeros(1944,2592);
image_array_low = cell(50,1);

for pic = 3:numel(low_gain_photos)
    filename = getfield(low_gain_photos, {pic}, 'name'); 
    im2 = imread(filename);
    image_array_low{pic-2} = im2;
end

for ii=1:1944
    for jj=1:2592
        val = 0;
        running_variance_low = zeros(numel(high_gain_photos)-2,1);
        % get pixel value
        for y = 1:50
            curr_image = image_array_low{y};    
            val = val + double(curr_image(ii,jj));
            running_variance_low(y) = double(curr_image(ii,jj));  
        end
        mymean = val/50;
        mean_array_low(ii,jj) = mymean;
        variance_array_low(ii,jj) = var(running_variance_low);
    end
end

variance_array_low = ceil(variance_array_low);
    
figure('Name','Low Gain Mean Pixel Values','NumberTitle','off')
colormap gray
imagesc(mean_array_low)

figure('Name','Low Gain Variance Pixel Values','NumberTitle','off')
colormap gray
imagesc(variance_array_low)


% 4. Variance as function of mean

% round means to nearest int/find avg variance for means with same val

% high gain
rounded_means_high = round(mean_array_high);
means_unique_high = unique(rounded_means_high);
variance_mean_high = zeros(length(means_unique_high),1);

for ii = 1:length(means_unique_high)
    temp = mean(variance_array_high(rounded_means_high == means_unique_high(ii)));
    variance_mean_high(ii) = temp;
end
variance_mean_high = round(variance_mean_high);

%low gain
rounded_means_low = round(mean_array_low);
means_unique_low = unique(rounded_means_low);
variance_mean_low = zeros(length(means_unique_low),1);

for ii = 1:length(means_unique_low)
    temp = mean(variance_array_low(rounded_means_low == means_unique_low(ii)));
    variance_mean_low(ii) = temp;
end
variance_mean_low = round(variance_mean_low);

figure('Name','High Gain Variance vs Mean','NumberTitle','off')
colormap gray
plot(means_unique_high, variance_mean_high, 'ro')

figure('Name','Low Gain Variance vs Mean','NumberTitle','off')
colormap gray
plot(means_unique_low, variance_mean_low, 'ro')

%5. Fit line

%High Gain
p1 = polyfit(means_unique_high, variance_mean_high, 1);
x1 = means_unique_high;
y1 = polyval(p1, means_unique_high);
figure('Name','High Gain Fitted Line','NumberTitle','off');
plot(means_unique_high, variance_mean_high, 'o')
hold on
plot(x1, y1);
hold off

%Low Gain
p2 = polyfit(means_unique_low, variance_mean_low, 1);
x1 = means_unique_low;
y1 = polyval(p2, means_unique_low);
figure('Name','Low Gain Fitted Line','NumberTitle','off');
plot(means_unique_low, variance_mean_low, 'o')
hold on
plot(x1, y1);
hold off

%7. 

stdev_high = sqrt(variance_mean_high);
stdev_low = sqrt(variance_mean_low);

SNR_high = zeros(length(stdev_high),1);
SNR_low = zeros(length(stdev_low),1);

for i = 1:length(stdev_high)
    SNR_high(i) = means_unique_high(i)/stdev_high(i);
end

for i = 1:length(stdev_low)
    SNR_low(i) = means_unique_low(i)/stdev_low(i);
end


figure('Name','SNR vs Mean High Gain','NumberTitle','off');
plot(means_unique_high,SNR_high);

figure('Name','SNR vs Mean Low Gain','NumberTitle','off');
plot(means_unique_low,SNR_low);


