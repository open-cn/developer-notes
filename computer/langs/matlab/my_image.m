
%1
img1=imread('mudan.jpg');    % Load image data
whos  img1
imshow(img1); % Display image
zoom on % Zoom image
zoom off % cancel zoom image
imwrite(lighter, 'mysaved.jpg');% Save image
dir mysaved.*% look up image


%2 simple handler
lighter = 2 * img1;

subplot(1,2,1);
imshow(img1);
title('Original');  % Display image

subplot(1,2,2);
imshow(lighter);
title('Lighter');    % Display image

%3 rgb2gray handler
black = rgb2gray(img1);
imshow(black)

%4 edge
%img2 = black
img2 = imread('**.tif')
img_edge1 = edge(img2,'sobel');       %sobel edge 
subplot(121),imshow(img_edge1)
img_edge2 = edge(img2,'canny');       %canny edge
subplot(122),imshow(img_edge2)
