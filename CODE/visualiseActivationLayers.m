
load randenData
currentCase =1;
load('D:\Acad\GitHub\Texture-Segmentation\TrainedNetworks\Network_Case_1_1.mat')

numLayers = size(net.Layers,1);
for k = 1:numLayers
    disp(k)
    actvn{k} = activations(net,uint8(dataRanden{currentCase}),net.Layers(k).Name);                     
end

% actvn1 = activations(net,uint8(dataRanden{currentCase}),'imageinput');
% actvn2 = activations(net,uint8(dataRanden{currentCase}),'conv_1');
% actvn3 = activations(net,uint8(dataRanden{currentCase}),'relu_1');
% actvn4 = activations(net,uint8(dataRanden{currentCase}),'maxpool');
% actvn5 = activations(net,uint8(dataRanden{currentCase}),'conv_2');
% actvn6 = activations(net,uint8(dataRanden{currentCase}),'relu_2');
% actvn7 = activations(net,uint8(dataRanden{currentCase}),'transposed-conv');
% actvn8 = activations(net,uint8(dataRanden{currentCase}),'conv_3');
% actvn9 = activations(net,uint8(dataRanden{currentCase}),'softmax');
% actvn10 = activations(net,uint8(dataRanden{currentCase}), 'classoutput');

%   actvn1           256x256                  262144  single                                       
%   actvn2           256x256x64             16777216  single                     
%   actvn3           256x256x64             16777216  single                     
%   actvn4           128x128x64              4194304  single                     
%   actvn5           128x128x64              4194304  single                     
%   actvn6           128x128x64              4194304  single                     
%   actvn7           256x256x64             16777216  single                     
%   actvn8           256x256x5               1310720  single                     
%   actvn9           256x256x5               1310720  single   
%   actvn10          256x256x5               1310720  single   
%%
imagesc(actvn18(:,:,7))

%%
load randenData
currentCase =1;
imageSize = size(dataRanden{currentCase});
% Load alexnet
net2 = alexnet;
layers = net2.Layers;
%Change the 
layers(1) = imageInputLayer(imageSize,'Name','imageinput' );
dataAlexNet = repmat(uint8(dataRanden{currentCase}(1:227,1:227)),[1 1 3]);
numLayers = size(net2.Layers,1);
for k = 1:numLayers
    disp(k)
    actvn{k} = activations(net2,dataAlexNet,net2.Layers(k).Name);                     
end

% actvn1 = activations(net2,dataAlexNet,'data'); 
% actvn2 = activations(net2,dataAlexNet,'conv1'); 
% actvn3 = activations(net2,dataAlexNet,'relu1'); 
% actvn4 = activations(net2,dataAlexNet,'norm1'); 
% actvn5 = activations(net2,dataAlexNet,'pool1'); 
% actvn6 = activations(net2,dataAlexNet,'conv2'); 
% actvn7 = activations(net2,dataAlexNet,'relu2');
% actvn8 = activations(net2,dataAlexNet,'norm2'); 
% actvn9 = activations(net2,dataAlexNet,'pool2'); 
% actvn10 = activations(net2,dataAlexNet,'conv3'); 
% actvn11 = activations(net2,dataAlexNet,'relu3'); 
% actvn12 = activations(net2,dataAlexNet,'conv4'); 
% actvn13 = activations(net2,dataAlexNet,'relu4'); 
% actvn14 = activations(net2,dataAlexNet,'conv5');
% actvn15 = activations(net2,dataAlexNet,'relu5'); 
% actvn16 = activations(net2,dataAlexNet,'pool5'); 
% actvn17 = activations(net2,dataAlexNet,'fc6'); 
% actvn18 = activations(net2,dataAlexNet,'relu6');
% actvn19 = activations(net2,dataAlexNet,'drop6'); 
% actvn20 = activations(net2,dataAlexNet,'fc7'); 
% actvn21 = activations(net2,dataAlexNet,'relu7'); 
% actvn22 = activations(net2,dataAlexNet,'drop7');
% actvn23 = activations(net2,dataAlexNet,'fc8'); 
% actvn24 = activations(net2,dataAlexNet,'prob'); 
% actvn25 = activations(net2,dataAlexNet,'output');


%   actvn1           227x227x3                618348  single                     
%   actvn2            55x55x96               1161600  single                     
%   actvn3            55x55x96               1161600  single                     
%   actvn4            55x55x96               1161600  single                     
%   actvn5            27x27x96                279936  single                     
%   actvn6            27x27x256               746496  single                     
%   actvn7            27x27x256               746496  single                     
%   actvn8            27x27x256               746496  single                     
%   actvn9            13x13x256               173056  single   
%   actvn10           13x13x384               259584  single                     
%   actvn11           13x13x384               259584  single                     
%   actvn12           13x13x384               259584  single                     
%   actvn13           13x13x384               259584  single                     
%   actvn14           13x13x256               173056  single                     
%   actvn15           13x13x256               173056  single                     
%   actvn16            6x6x256                 36864  single                     
%   actvn17            1x1x4096                16384  single                     
%   actvn18            1x1x4096                16384  single                     
%   actvn19            1x1x4096                16384  single                     
%   actvn20            1x1x4096                16384  single                     
%   actvn21            1x1x4096                16384  single                     
%   actvn22            1x1x4096                16384  single                     
%   actvn23            1x1x1000                 4000  single                     
%   actvn24            1x1x1000                 4000  single                     
%   actvn25            1x1x1000                 4000  single                     


%%
dataGoogLeNet = repmat(uint8(dataRanden{currentCase}(1:224,1:224)),[1 1 3]);
numLayers = size(net4.Layers,1);
for k = 1:numLayers
    disp(k)
    actvn{k} = activations(net4,dataGoogLeNet,net4.Layers(k).Name);                     
end

%%

imagesc(actvn{20}(:,:,22))

%%
k=10;
montage(actvn{k}(:,:,:)/max(max(max(actvn{k}))))
colormap(jet)
