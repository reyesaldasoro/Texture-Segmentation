

numFilters = 64;
filterSize = 3;
numClasses = 5;
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
    ]
%%
opts = trainingOptions('sgdm', ...
    'InitialLearnRate',1e-3, ...
    'MaxEpochs',100, ...
    'MiniBatchSize',64);
trainingData = pixelLabelImageDatastore(imds,pxds);

%%
net = trainNetwork(trainingData,layers,opts);

%%

testImage = uint8(dataRanden{1});
imshow(testImage)

%%
save textureNet_good_class net

%%

[C,score,allScores] = semanticseg(testImage,net);
B = labeloverlay(testImage,C);
imshow(B)

%%
BW = (C == 'T1') +2*(C == 'T2') +3*(C == 'T3') +4*(C == 'T4') +5*(C == 'T5')  ;
imagesc(BW)