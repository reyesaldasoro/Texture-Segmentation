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

%% Prepare Randen Conditions
load randenData
% dataRanden    -  cell with the composite images
% trainRanden   -  cell with the training data for each image
% maskRanden    -  cell with the masks for each of the composite images
clear resRanden stdsRanden meansRanden fname ind edge error*

currentCase                 = 1;%:9
[rows,cols,numClasses]      = size(trainRanden{currentCase});
imageDir                    = fullfile(dataSetDir,strcat('trainingImages',filesep,'Case_',num2str(currentCase)));
labelDir                    = fullfile(dataSetDir,strcat('trainingLabels',filesep,'Case_',num2str(currentCase)));

% These are the data stores with the training pairs and training labels
% They can be later used to create montages of the pairs.
imds                        = imageDatastore(imageDir);
imds2                       = imageDatastore(labelDir);

clear classNames
for counterClass =1:numClasses
    classNames(counterClass) = strcat("T",num2str(counterClass));
end
% The labels are simply the numbers of the textures, same numbers
% as with the classNames. For randen examples, these vary 1-5, 1-16, 1-10
labelIDs                    = (1:numClasses);
pxds                        = pixelLabelDatastore(labelDir,classNames,labelIDs);

trainingData                = pixelLabelImageDatastore(imds,pxds);
%% Load alexnet
net2                        = alexnet;
layers                      = net2.Layers;
%Change the input layer to the size of the randen case
%layers(1) = imageInputLayer([rows cols],'Name','data' );
layers(1) = imageInputLayer([32 32],'Name','data' );

%layers(2) = convolution2dLayer( layers(2,1).FilterSize(1), layers(2,1).NumFilters,...
%                               'Name',layers(2,1).Name,'Stride',layers(2,1).Stride,...
%                               'Padding', layers(2,1).PaddingSize);%,...
                           %'Weights', layers(2,1).Weights,'Bias',layers(2,1).Bias);
                           
  
conv1 = layers(2);
conv1New = convolution2dLayer(conv1.FilterSize, conv1.NumFilters, ...
    'Stride', conv1.Stride, ...
    'Padding', [100 100], ...
    'NumChannels', 1, ...
    'WeightLearnRateFactor', conv1.WeightLearnRateFactor, ...
    'WeightL2Factor', conv1.WeightL2Factor, ...
    'BiasLearnRateFactor', conv1.BiasLearnRateFactor, ...
    'BiasL2Factor', conv1.BiasL2Factor, ...
    'Name', conv1.Name);
%conv1New.Weights = conv1.Weights;
%conv1New.Bias = conv1.Bias;
layers(2) = conv1New;
%%                           
% Resize Randen to the size of AlexNet (no need if adjusting the first layer)
% dataAlexNet = repmat(uint8(dataRanden{currentCase}(1:227,1:227)),[1 1 3]);
% fc6 is layers 17
idx = 17;
weights                 = layers(idx).Weights';
weights                 = reshape(weights, 6, 6, 256, 4096);
bias                    = reshape(layers(idx).Bias, 1, 1, []);

layers(idx)             = convolution2dLayer(6, 4096, 'NumChannels', 256, 'Name', 'fc6');
layers(idx).Weights     = weights;
layers(idx).Bias        = bias;
% fc7 is layers 20
idx                     = 20;
weights                 = layers(idx).Weights';
weights                 = reshape(weights, 1, 1, 4096, 4096);
bias                    = reshape(layers(idx).Bias, 1, 1, []);

layers(idx)             = convolution2dLayer(1, 4096, 'NumChannels', 4096, 'Name', 'fc7');
layers(idx).Weights     = weights;
layers(idx).Bias        = bias;
% remove the last two layers
layers(end-2:end)       = [];
upscore = transposedConv2dLayer(64, numClasses, ...
    'NumChannels', numClasses, 'Stride', 32, 'Name', 'upscore');

layers = [
    layers
    convolution2dLayer(1, numClasses, 'Name', 'score_fr');
    upscore
    crop2dLayer('centercrop', 'Name', 'score')
    softmaxLayer('Name', 'softmax')
    pixelClassificationLayer('Name', 'pixelLabels')
    ];

lgraph = layerGraph(layers);

% imageInputLayer????CropLayer????????
lgraph = connectLayers(lgraph, 'data', 'score/ref');

%% Training
options = trainingOptions('sgdm', ...
    'Momentum', 0.9, ...
    'InitialLearnRate', 1e-3, ...
    'L2Regularization', 0.0005, ...
    'MaxEpochs', 30, ...
    'MiniBatchSize', 64, ...
    'Shuffle', 'every-epoch', ...
    'Plots','training-progress', ...
    'VerboseFrequency', 100);

[net3, info] = trainNetwork(trainingData,lgraph,options);


        C = semanticseg(uint8(dataRanden{currentCase}),net3);
        B = labeloverlay(uint8(dataRanden{currentCase}), C);
        figure
        imagesc(B)


% %%
% layers = net2.Layers;
% 
% layers(23) = fullyConnectedLayer(5);
% layers(end) = classificationLayer();
% options = trainingOptions('adam','InitialLearnRate',0.0001);
% net = trainNetwork(trainds,layers, options);
% 
% 
% 
% load('D:\Acad\GitHub\Texture-Segmentation\TrainedNetworks\Network_Case_1_1.mat')
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %%
% %load textureNet2
% % select one of the composite images
% for caseEncoder =1%:3
%     switch caseEncoder
%         case 1
%             dir_nets        = dir ('Network_Case_?A.mat');
%             typeEncoder     = 'sgdm';
%             nameEncoder     = 'A';
%         case 2
%             dir_nets        = dir ('Network_Case_?B.mat');
%             typeEncoder     = 'adam';
%             nameEncoder     = 'B';
%         case 3
%             dir_nets        = dir ('Network_Case_?C.mat');
%             typeEncoder     = 'rmsprop';
%             nameEncoder     = 'C';
%     end
%     
%     for currentCase                 = 1%:9
%         [rows,cols,numClasses]      = size(trainRanden{currentCase});
%         imageDir = fullfile(dataSetDir,strcat('trainingImages',filesep,'Case_',num2str(currentCase)));
%         labelDir = fullfile(dataSetDir,strcat('trainingLabels',filesep,'Case_',num2str(currentCase)));
%         
%         imageSize = [rows cols];
%         %numClasses = 5;
%         encoderDepth = 4;
%         % These are the data stores with the training pairs and training labels
%         % They can be later used to create montages of the pairs.
%         imds  = imageDatastore(imageDir); 
%         imds2 = imageDatastore(labelDir);
% 
%         % The class names are a sequence of options for the textures, e.g.
%         % classNames = ["T1","T2","T3","T4","T5"];
%         clear classNames
%         for counterClass=1:numClasses
%             classNames(counterClass) = strcat("T",num2str(counterClass));
%         end
%         % The labels are simply the numbers of the textures, same numbers 
%         % as with the classNames. For randen examples, these vary 1-5, 1-16, 1-10
%         labelIDs   = (1:numClasses);
%         
%         pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);
%         
%         
%         % Definition of the network to be trained.
%         numFilters                  = 64;
%         filterSize                  = 3;
%         %numClasses = 5;
%         layers = [
%             imageInputLayer([32 32 1])
%             convolution2dLayer(filterSize,numFilters,'Padding',1)
%             reluLayer()
%             maxPooling2dLayer(2,'Stride',2)
%             convolution2dLayer(filterSize,numFilters,'Padding',1)
%             reluLayer()
%             transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
%             convolution2dLayer(1,numClasses);
%             softmaxLayer()
%             pixelClassificationLayer()
%             ];
%         
%         opts = trainingOptions(typeEncoder, ...
%             'InitialLearnRate',1e-3, ...
%             'MaxEpochs',100, ...
%             'MiniBatchSize',64);
% 
%         trainingData        = pixelLabelImageDatastore(imds,pxds);
%         nameNet             = strcat(dataSetDir,'Network_Case_',num2str(currentCase),nameEncoder);
%         disp(nameNet)
%         net                 = trainNetwork(trainingData,layers,opts);
% 
%         save(nameNet,'net')
%         
%         %
%         C = semanticseg(uint8(dataRanden{currentCase}),net);
%         B = labeloverlay(uint8(dataRanden{currentCase}), C);
%         figure
%         imagesc(B)
%     end
% end