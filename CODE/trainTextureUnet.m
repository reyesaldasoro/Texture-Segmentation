%% Clear all variables and close all figures
clear all
close all
clc

%% Read the files that have been stored in the current folder
if strcmp(filesep,'/')
    % Running in Mac
    cd ('/Users/ccr22/Acad/GitHub/Texture-Segmentation/CODE')    
    dataSetDir='/Users/ccr22/Acad/GitHub/Texture-Segmentation/CODE';
else
    % running in windows
    dataSetDir ='D:\Acad\GitHub\Texture-Segmentation\CODE';
    cd ('D:\Acad\GitHub\Texture-Segmentation\CODE')
end
%%
load randenData

% dataRanden    -  cell with the composite images
% trainRanden   -  cell with the training data for each image
% maskRanden    -  cell with the masks for each of the composite images

clear resRanden stdsRanden meansRanden fname ind edge error*

%%
imageDir = fullfile(dataSetDir,'trainingImages2');
labelDir = fullfile(dataSetDir,'trainingLabels2');
%%

imageSize = [256 256];
numClasses = 5;
encoderDepth = 3;
lgraph = unetLayers(imageSize,numClasses,'EncoderDepth',encoderDepth);

%%
imds = imageDatastore(imageDir);
%%
classNames = ["T5","T4","T3","T2","T1"];
labelIDs   = [5 4 3 2 1];
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);
%%
imageSize = [32 32];
%numClasses = 5;
lgraph = unetLayers(imageSize, numClasses);
%%

ds = pixelLabelImageDatastore(imds,pxds);
%%
options = trainingOptions('sgdm','InitialLearnRate',1e-3, ...
    'MaxEpochs',20,'VerboseFrequency',10);
%%
net = trainNetwork(ds,lgraph,options);

%%
save textureNet2class net

%%

