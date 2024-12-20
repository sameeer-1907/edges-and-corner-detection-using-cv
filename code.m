% Read the image (grayscale)
I = imread('clg.jpg'); % Load your image here
if size(I,3) == 3
    I = rgb2gray(I); % Convert to grayscale if it's a color image
end

% Convert to double for precision
I = double(I);

% Define Sobel filters for computing derivatives
sobel_x = [-1 0 1; -2 0 2; -1 0 1]; % Gradient in x-direction
sobel_y = sobel_x';                 % Gradient in y-direction

% Compute first-order derivatives
Ix = conv2(I, sobel_x, 'same'); % Derivative w.r.t x
Iy = conv2(I, sobel_y, 'same'); % Derivative w.r.t y

% Compute second-order derivatives
Ixx = conv2(Ix, sobel_x, 'same'); % Second derivative w.r.t x
Iyy = conv2(Iy, sobel_y, 'same'); % Second derivative w.r.t y
Ixy = conv2(Ix, sobel_y, 'same'); % Mixed derivative

% Hessian matrix components for each pixel
% [ Ixx Ixy ]
% [ Ixy Iyy ]

% Compute the determinant of the Hessian matrix
detH = (Ixx .* Iyy) - (Ixy .^ 2);

% Normalize determinant to a range for visualization
detH = detH / max(detH(:));

% Threshold to detect corners (adjust threshold as needed)
corner_threshold = 0.01;
corners = detH > corner_threshold;

% Display results
figure;
subplot(1,2,1), imshow(I, []), title('Original Image');
subplot(1,2,2), imshow(corners), title('Hessian Corners Detected');
