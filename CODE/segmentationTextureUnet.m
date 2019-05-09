%% Clear all variables and close all figures
clear all
close all
clc

%% Read the files that have been stored in the current folder
if strcmp(filesep,'/')
    % Running in Mac
%    load('/Users/ccr22/OneDrive - City, University of London/Acad/ARC_Grant/Datasets/DataARC_Datasets_2019_05_03.mat')
    cd ('/Users/ccr22/Acad/GitHub/Texture-Segmentation/CODE')
%    baseDir                             = 'Metrics_2019_04_25/metrics/';
else
    % running in windows
    cd ('D:\Acad\GitHub\Texture-Segmentation\CODE')
end
%%
load randenData

% dataRanden    -  cell with the composite images
% trainRanden   -  cell with the training data for each image
% maskRanden    -  cell with the masks for each of the composite images

clear resRanden stdsRanden meansRanden fname ind edge error*
%% Augmentation of training data for classification with U-Net

% select one of the composite images
currentCase             = 1;

% Partition to create a large number of images to train 
imageSize               = [32 32];
stepOverlap             = 16;
%%

[rows,cols,classes]     = size(trainRanden{currentCase});

for counterR=1:imageSize(1)-stepOverlap:rows-imageSize(1)
    for counterC=1:imageSize(2)-stepOverlap:cols-imageSize(2)
%         imagesc(trainRanden{currentCase}(counterR:counterR+imageSize(1),counterC:counterC+imageSize(2),1))
%         title(strcat(num2str(counterR),'-',num2str(counterC)))
%         pause(0.1)
%         drawnow;        
    end
end
