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
stepOverlap             = 0;%16;
%%
figure(1)
colormap gray
[rows,cols,numClasses]     = size(trainRanden{currentCase});
counterClasses  = 1;
counterR        = 1;
counterC        = 1;
%% Prepare training classes to be just one class per image
for counterClasses = 1:numClasses
    for counterR=1:imageSize(1)-stepOverlap:rows-imageSize(1)
        for counterC=1:imageSize(2)-stepOverlap:cols-imageSize(2)
            currentSection  = uint8(trainRanden{currentCase}(counterR:counterR+imageSize(1)-1,counterC:counterC+imageSize(2)-1,counterClasses));
            currentLabel    = uint8(ones(32)*counterClasses);
            % Display
            imagesc(currentSection)
            title(strcat('Class = ',num2str(counterClasses),32,32,'(',num2str(counterR),'-',num2str(counterC),')'))
            pause(0.01)
            drawnow;
            % Save
            fName = strcat('Texture_Randen_Class_',num2str(counterClasses),'_',num2str(counterR),'_',num2str(counterC),'.png');
            fNameL = strcat('Texture_Randen_Label_Class_',num2str(counterClasses),'_',num2str(counterR),'_',num2str(counterC),'.png');
            imwrite(currentSection,strcat('trainingImages\',fName))
            imwrite(currentLabel,strcat('trainingLabels\',fNameL))
            
            
        end
    end
end
%%

%% Prepare training classes to be just two classes per image
for counterClass_1 = 1:numClasses
    for counterClass_2 = 1:numClasses
        if counterClass_1~=counterClass_2
            for counterR=1:imageSize(1)-stepOverlap:rows-imageSize(1)
                for counterC=1:imageSize(2)-stepOverlap:cols-imageSize(2)
                    currentSection_1    = uint8(trainRanden{currentCase}(counterR:counterR+imageSize(1)-1,counterC:counterC+imageSize(2)-1,counterClass_1));
                    currentLabel_1      = uint8(ones(32)*counterClass_1);
                    currentSection_2    = uint8(trainRanden{currentCase}(counterR:counterR+imageSize(1)-1,counterC:counterC+imageSize(2)-1,counterClass_2));
                    currentLabel_2      = uint8(ones(32)*counterClass_2);
                    
                    currentSection      = [currentSection_1(:,1:16) currentSection_2(:,1:16)] ;
                    currentLabel        = [currentLabel_1(:,1:16) currentLabel_2(:,1:16)];
                    % Display
                    imagesc(currentSection)
                    title(strcat('Classes = ',num2str(counterClass_1),'/',num2str(counterClass_2),32,32,'(',num2str(counterR),'-',num2str(counterC),')'))
                    pause(0.01)
                    drawnow;
                    % Save
                    fName = strcat('Texture_Randen_Class_',num2str(counterClasses),'_',num2str(counterR),'_',num2str(counterC),'.png');
                    fNameL = strcat('Texture_Randen_Label_Class_',num2str(counterClasses),'_',num2str(counterR),'_',num2str(counterC),'.png');
                    imwrite(currentSection,strcat('trainingImages2\',fName))
                    imwrite(currentLabel,strcat('trainingLabels2\',fNameL))
                    
                    
                end
            end
        end
    end
end
