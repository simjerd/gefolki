%% -------- Open all data     ---------------------------------------------
tic;

im1 = imread('../datasets/ew_1.tif','tif');            	% RGB image in Pauli basis
im2 = imread('../datasets/ew_2.tif','tif');            	% RGB image in Pauli basis


%% -------- im2 over im1  ---------------------------------------------
% Define the parameter

para = struct('radius' , 32:-4:8, ...
        'levels' , 6, ...
        'iter' , 2, ...
        'contrast_adapt', true, ...
        'rank', 4);

% Compute the flow    
W_12 = GeFolki(im1, im2, para);

% Resample the image 
im2_resampled = Gefolki_interpflow(im1, im2, W_12);

toc;
