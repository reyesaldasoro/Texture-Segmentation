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
dir_nets = dir ('Network_Case*');

%% Create Network
%load textureNet2
% select one of the composite images
for currentCase                 = 1:9
    [rows2,cols2,numClasses]      = size(trainRanden{currentCase});
    [rows,cols,numClasses2]      = size(dataRanden{currentCase});
    %
    load (dir_nets(currentCase).name);
    C = semanticseg(uint8(dataRanden{currentCase}),net);
    B = labeloverlay(uint8(dataRanden{currentCase}), C);
    figure(currentCase)
    imagesc(B)
    % Convert from semantic to numeric
    result = zeros(rows,cols);
    for counterClass=1:numClasses
        %strcat('T',num2str(counterClass))
        %result = result + counterClass*((C==strcat('T',num2str(counterClass))));    
        result = result +(counterClass*(C==strcat('T',num2str(counterClass))));
    end
    figure(10+currentCase)
    imagesc(result==maskRanden{currentCase})
    accuracy=sum(sum(result==maskRanden{currentCase}))/rows/cols;
    disp([currentCase accuracy])
    
    
end