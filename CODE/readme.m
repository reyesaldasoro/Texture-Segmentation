%% Clear all the data and close all windows
clear all
close all
%% Load the matrix with the data from Randen's paper
load randenData
whos

%% display the first composite image with five textures
imagesc(dataRanden{1})
colormap gray

%% display the corresponding mask
imagesc(maskRanden{1})
colormap jet
%% display a montage with the training data
montage(mat2gray( trainRanden{1}))

%%

