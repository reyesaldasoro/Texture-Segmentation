%% Clear all variables and close all figures
clear all
close all
clc

%% Read the files that have been stored in the current folder
if strcmp(filesep,'/')
    % Running in Mac
%    load('/Users/ccr22/OneDrive - City, University of London/Acad/ARC_Grant/Datasets/DataARC_Datasets_2019_05_03.mat')
    cd ('/Users/ccr22/OneDrive - City, University of London/Acad/Research/texture')
%    baseDir                             = 'Metrics_2019_04_25/metrics/';
else
    % running in windows
    cd ('D:\OneDrive - City, University of London\Acad\Research\texture')
end

%%
load randenData

% dataRanden    -  cell with the composite images
% trainRanden   -  cell with the training data for each image
% maskRanden    -  cell with the masks for each of the composite images


%% Augmentation of training data for classification with U-Net

% select one of the composite images
currentCase = 1;

% Partition to create a large number of images to train 
imageSize = [32 32];

