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
    dataSaveDir = '/Users/ccr22/OneDrive - City, University of London/Acad/Research/texture/Results/';
 
else
    % running in windows
    %    dataSetDir ='D:\Acad\GitHub\Texture-Segmentation\CODE';
    dataSetDir =  'D:\OneDrive - City, University of London\Acad\Research\texture\Horiz_Vert_Diag\';
    dataSaveDir = 'D:\OneDrive - City, University of London\Acad\Research\texture\Results\';
    
    cd ('D:\Acad\GitHub\Texture-Segmentation\CODE')
end
%%
load randenData
% dataRanden    -  cell with the composite images
% trainRanden   -  cell with the training data for each image
% maskRanden    -  cell with the masks for each of the composite images
clear resRanden stdsRanden meansRanden fname ind edge error*

accuracy(3,9,3,4) = 0;
%% Loop for training and segmentation
% select one of the composite images of the randen cases, there are 9 images
for currentCase                 = 1:9
    % dimensions of the data
    [rows,cols,numClasses]      = size(trainRanden{currentCase});
    % location of the training data data and labels are stored as pairs of textures arranged in Horizontal,
    % Vertical and Diagonal pairs of class 1-2, 1-3, 1-4 ... 2-1, 2-3,...
    imageDir                    = fullfile(dataSetDir,strcat('trainingImages',filesep,'Case_',num2str(currentCase)));
    labelDir                    = fullfile(dataSetDir,strcat('trainingLabels',filesep,'Case_',num2str(currentCase)));
    imageSize                   = [rows cols];
    encoderDepth                = 4;
    % These are the data stores with the training pairs and training labels
    % They can be later used to create montages of the pairs.
    imds                        = imageDatastore(imageDir);
    imds2                       = imageDatastore(labelDir);
    % The class names are a sequence of options for the textures, e.g.
    % classNames = ["T1","T2","T3","T4","T5"];
    clear classNames
    for counterClass=1:numClasses
        classNames(counterClass) = strcat("T",num2str(counterClass));
    end
    % The labels are simply the numbers of the textures, same numbers
    % as with the classNames. For randen examples, these vary 1-5, 1-16, 1-10
    labelIDs                    = (1:numClasses);
    pxds                        = pixelLabelDatastore(labelDir,classNames,labelIDs);
    for numEpochsName=1:4
        switch numEpochsName
            case 1
                numEpochs       = 10;
            case 2
                numEpochs       = 20;
            case 3
                numEpochs       = 50;
            case 4
                numEpochs       = 100;
        end
        
        % try with different encoders
        for caseEncoder =1:3
            switch caseEncoder
                case 1
                    dir_nets        = dir ('Network_Case_?A.mat');
                    typeEncoder     = 'sgdm';
                    nameEncoder     = '1';
                case 2
                    dir_nets        = dir ('Network_Case_?B.mat');
                    typeEncoder     = 'adam';
                    nameEncoder     = '2';
                case 3
                    dir_nets        = dir ('Network_Case_?C.mat');
                    typeEncoder     = 'rmsprop';
                    nameEncoder     = '3';
            end
            
            % Definition of the network to be trained.
            numFilters                  = 64;
            filterSize                  = 3;
            
            for numLayersNetwork =1:3
                switch numLayersNetwork
                    case 1
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
                        nameLayers     = '10';
                    case 2
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
                            maxPooling2dLayer(2,'Stride',2)
                            convolution2dLayer(filterSize,numFilters,'Padding',1)
                            reluLayer()
                            transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
                            convolution2dLayer(1,numClasses);
                            transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
                            convolution2dLayer(1,numClasses);
                            transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
                            convolution2dLayer(1,numClasses);
                            softmaxLayer()
                            pixelClassificationLayer()
                            ];
                        
                        nameLayers     = '15';
                    case 3
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
                            maxPooling2dLayer(2,'Stride',2)
                            convolution2dLayer(filterSize,numFilters,'Padding',1)
                            reluLayer()
                            transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
                            convolution2dLayer(1,numClasses);
                            transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
                            convolution2dLayer(1,numClasses);
                            transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
                            convolution2dLayer(1,numClasses);
                            softmaxLayer()
                            pixelClassificationLayer()
                            ];
                        
                        nameLayers     = '20';
                end
                
                
                opts = trainingOptions(typeEncoder, ...
                    'InitialLearnRate',1e-3, ...
                    'MaxEpochs',numEpochs, ...
                    'MiniBatchSize',64);
                
                trainingData        = pixelLabelImageDatastore(imds,pxds);
                nameNet             = strcat(dataSaveDir,'Network_Case_',num2str(currentCase),'_Enc_',nameEncoder,'_numL_',nameLayers,'_NumEpochs_',num2str(numEpochs));
                disp(nameNet)
                net                 = trainNetwork(trainingData,layers,opts);
                
                save(nameNet,'net')
                
                %
                C = semanticseg(uint8(dataRanden{currentCase}),net);
                %B = labeloverlay(uint8(dataRanden{currentCase}), C);
                %figure
                %imagesc(B)
                
                % Convert from semantic to numeric
                result = zeros(rows,cols);
                for counterClass=1:numClasses
                    %strcat('T',num2str(counterClass))
                    %result = result + counterClass*((C==strcat('T',num2str(counterClass))));
                    result = result +(counterClass*(C==strcat('T',num2str(counterClass))));
                end
                %figure(10*counterOptions+currentCase)
                %imagesc(result==maskRanden{currentCase})
                accuracy(numLayersNetwork,currentCase,caseEncoder,numEpochsName)=sum(sum(result==maskRanden{currentCase}))/rows/cols;
                save(strcat(dataSaveDir,'accuracy'),'accuracy')
            end
        end
    end
end

misclassification = 100*(1-accuracy);
