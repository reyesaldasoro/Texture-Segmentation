%% 
clear all
close all
%%
load randenData
whos

%%
imagesc(dataRanden{1})
colormap gray

%%
imagesc(maskRanden{1})
colormap jet
%%
montage(mat2gray( trainRanden{1}))

