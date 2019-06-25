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

%% Create Network
%load textureNet2
% select one of the composite images
for currentCase                 = 8:9
[rows,cols,numClasses]      = size(trainRanden{currentCase});
imageDir = fullfile(dataSetDir,strcat('trainingImages',filesep,'Case_',num2str(currentCase)));
labelDir = fullfile(dataSetDir,strcat('trainingLabels',filesep,'Case_',num2str(currentCase)));


imageSize = [rows cols];
%numClasses = 5;
encoderDepth = 4;
imds = imageDatastore(imageDir);
clear classNames
for counterClass=1:numClasses
    classNames(counterClass) = strcat("T",num2str(counterClass));
end
%classNames = ["T1","T2","T3","T4","T5"];
labelIDs   = (1:numClasses);
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);


%
numFilters                  = 64;
filterSize                  = 3;
%numClasses = 5;
layers = [
    imageInputLayer([32 32 1])
    convolution2dLayer(filterSize,numFilters,'Padding',1)
    reluLayer()
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(filterSize,numFilters,'Padding',1)
    reluLayer()
    transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
    convolution2dLayer(1,numClasses);
    softmaxLayer()
    pixelClassificationLayer()
    ];

opts = trainingOptions('sgdm', ...
    'InitialLearnRate',1e-3, ...
    'MaxEpochs',100, ...
    'MiniBatchSize',64);
trainingData = pixelLabelImageDatastore(imds,pxds);

net = trainNetwork(trainingData,layers,opts);

nameNet = strcat('Network_Case_',num2str(currentCase));
save(nameNet,'net')

%
C = semanticseg(uint8(dataRanden{currentCase}),net);
B = labeloverlay(uint8(dataRanden{currentCase}), C);
figure
imagesc(B)
end