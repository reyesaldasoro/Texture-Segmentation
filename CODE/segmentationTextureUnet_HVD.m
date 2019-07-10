%% Clear all variables and close all figures
clear all
close all
clc

%% Read the files that have been stored in the current folder
if strcmp(filesep,'/')
    % Running in Mac
    cd ('/Users/ccr22/Academic/GitHub/Texture-Segmentation/CODE')
    %dataSetDir='/Users/ccr22/Academic/GitHub/Texture-Segmentation/CODE';
    dataSetDir='/Users/ccr22/OneDrive - City, University of London/Acad/Research/texture/Horiz_Vert_Diag/';
else
    % running in windows
    %    dataSetDir ='D:\Acad\GitHub\Texture-Segmentation\CODE';
    dataSetDir =  'D:\OneDrive - City, University of London\Acad\Research\texture\Horiz_Vert_Diag\';    
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
for caseEncoder =1%:3
    switch caseEncoder
        case 1
            dir_nets        = dir ('Network_Case_?A.mat');
            typeEncoder     = 'sgdm';
            nameEncoder     = 'A';
        case 2
            dir_nets        = dir ('Network_Case_?B.mat');
            typeEncoder     = 'adam';
            nameEncoder     = 'B';
        case 3
            dir_nets        = dir ('Network_Case_?C.mat');
            typeEncoder     = 'rmsprop';
            nameEncoder     = 'C';
    end
    
    for currentCase                 = 1%:9
        [rows,cols,numClasses]      = size(trainRanden{currentCase});
        imageDir = fullfile(dataSetDir,strcat('trainingImages',filesep,'Case_',num2str(currentCase)));
        labelDir = fullfile(dataSetDir,strcat('trainingLabels',filesep,'Case_',num2str(currentCase)));
        
        imageSize = [rows cols];
        %numClasses = 5;
        encoderDepth = 4;
        % These are the data stores with the training pairs and training labels
        % They can be later used to create montages of the pairs.
        imds  = imageDatastore(imageDir); 
        imds2 = imageDatastore(labelDir);

        % The class names are a sequence of options for the textures, e.g.
        % classNames = ["T1","T2","T3","T4","T5"];
        clear classNames
        for counterClass=1:numClasses
            classNames(counterClass) = strcat("T",num2str(counterClass));
        end
        % The labels are simply the numbers of the textures, same numbers 
        % as with the classNames. For randen examples, these vary 1-5, 1-16, 1-10
        labelIDs   = (1:numClasses);
        
        pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);
        
        
        % Definition of the network to be trained.
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
            maxPooling2dLayer(2,'Stride',2)
            convolution2dLayer(filterSize,numFilters,'Padding',1)
            reluLayer()
            transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
            convolution2dLayer(1,numClasses);
            transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
            convolution2dLayer(1,numClasses);
            softmaxLayer()
            pixelClassificationLayer()
            ];
        
        opts = trainingOptions(typeEncoder, ...
            'InitialLearnRate',1e-3, ...
            'MaxEpochs',100, ...
            'MiniBatchSize',64);

        trainingData        = pixelLabelImageDatastore(imds,pxds);
        nameNet             = strcat(dataSetDir,'Network_Case_',num2str(currentCase),nameEncoder);
        disp(nameNet)
        net                 = trainNetwork(trainingData,layers,opts);

        %save(nameNet,'net')
        
        %
        C = semanticseg(uint8(dataRanden{currentCase}),net);
        B = labeloverlay(uint8(dataRanden{currentCase}), C);
        figure
        imagesc(B)
    end
end