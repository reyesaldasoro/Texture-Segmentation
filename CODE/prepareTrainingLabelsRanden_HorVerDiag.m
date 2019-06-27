%% Clear all variables and close all figures
clear all
close all
clc

%% Read the files that have been stored in the current folder
if strcmp(filesep,'/')
    % Running in Mac
    %    load('/Users/ccr22/OneDrive - City, University of London/Acad/ARC_Grant/Datasets/DataARC_Datasets_2019_05_03.mat')
    cd ('/Users/ccr22/Acad/GitHub/Texture-Segmentation/CODE')
    %dataSetDir =  'D:\OneDrive - City, University of London\Acad\Research\texture\Horiz_Vert_Diag';
    
    %    baseDir                             = 'Metrics_2019_04_25/metrics/';
else
    % running in windows
    cd ('D:\Acad\GitHub\Texture-Segmentation\CODE')
    dataSetDir =  'D:\OneDrive - City, University of London\Acad\Research\texture\Horiz_Vert_Diag\';

end
%%
load randenData

% dataRanden    -  cell with the composite images
% trainRanden   -  cell with the training data for each image
% maskRanden    -  cell with the masks for each of the composite images

clear resRanden stdsRanden meansRanden fname ind edge error*
%% Augmentation of training data for classification with U-Net 
% Partition to create a large number of images to train
imageSize               = [32 32];
stepOverlap             = 0;%16;
figure(1)
h2=imagesc(ones(32));
colormap gray




counterClasses  = 1;
counterR        = 1;
counterC        = 1;

[rr,cc]         = meshgrid(1:32,1:32);

D1              = uint8(cc>rr);
D2              = uint8(cc<=rr);

%% Prepare training classes to be just two classes per image


for currentCase             = 1:9
    % select one of the composite images
    [rows,cols,numClasses]     = size(trainRanden{currentCase});
    for counterClass_1 = 1:numClasses
        % First class
        for counterClass_2 = 1:numClasses
            % Second Class
            if counterClass_1~=counterClass_2
                %only if different
                for counterR=1:imageSize(1)-stepOverlap:rows-imageSize(1)
                    % Loop over rows
                    for counterC=1:imageSize(2)-stepOverlap:cols-imageSize(2)
                        %loop over cols
                        
                        % Prepare classes and labels
                        currentSection_1    = uint8(trainRanden{currentCase}(counterR:counterR+imageSize(1)-1,counterC:counterC+imageSize(2)-1,counterClass_1));
                        currentLabel_1      = uint8(ones(32)*counterClass_1);
                        currentSection_2    = uint8(trainRanden{currentCase}(counterR:counterR+imageSize(1)-1,counterC:counterC+imageSize(2)-1,counterClass_2));
                        currentLabel_2      = uint8(ones(32)*counterClass_2);
                        
                        % Horizontal Pair Arrangement
                        currentSectionH      = [currentSection_1(:,1:16) currentSection_2(:,1:16)] ;
                        currentLabelH        = [currentLabel_1(:,1:16) currentLabel_2(:,1:16)];
                        
                        % Vertical Pair Arrangement
                        currentSectionV      = [currentSection_1(1:16,:) ;currentSection_2(1:16,:)] ;
                        currentLabelV        = [currentLabel_1(1:16,:) ;currentLabel_2(1:16,:)];
                        
                        % Diagonal Pair Arrangement
                        currentSectionD      = (currentSection_1.*(D1) + currentSection_2.*D2) ;
                        currentLabelD        = (currentLabel_1.*(D1)    + currentLabel_2.*D2);
                        
                        
                        % Display and Save Horizontal
                        %imagesc(currentSection)
                        h2.CData = currentSectionH;
                        title(strcat('H Classes = ',num2str(counterClass_1),'/',num2str(counterClass_2),32,32,'(',num2str(counterR),'-',num2str(counterC),')'))
                        %pause(0.01)
                        drawnow;
                        % Save
                        fName  = strcat('Texture_Randen_Classes_H_',num2str(counterClass_1),'_',num2str(counterClass_2),      'R_',num2str(counterR),'C_',num2str(counterC),'.png');
                        fNameL = strcat('Texture_Randen_Label_Classes_H_',num2str(counterClass_1),'_',num2str(counterClass_2),'R_',num2str(counterR),'C_',num2str(counterC),'.png');
                        imwrite(currentSectionH,strcat(dataSetDir,'trainingImages',filesep,'Case_',num2str(currentCase),filesep,fName))
                        imwrite(currentLabelH,strcat(dataSetDir,'trainingLabels',filesep,'Case_',num2str(currentCase),filesep,fNameL))
                        
                       % Display and Save Vertical
                        %imagesc(currentSection)
                        h2.CData = currentSectionV;
                        title(strcat('V Classes = ',num2str(counterClass_1),'/',num2str(counterClass_2),32,32,'(',num2str(counterR),'-',num2str(counterC),')'))
                        %pause(0.01)
                        drawnow;
                        % Save
                        fName  = strcat('Texture_Randen_Classes_V_',num2str(counterClass_1),'_',num2str(counterClass_2),      'R_',num2str(counterR),'C_',num2str(counterC),'.png');
                        fNameL = strcat('Texture_Randen_Label_Classes_V_',num2str(counterClass_1),'_',num2str(counterClass_2),'R_',num2str(counterR),'C_',num2str(counterC),'.png');
                        imwrite(currentSectionV,strcat(dataSetDir,'trainingImages',filesep,'Case_',num2str(currentCase),filesep,fName))
                        imwrite(currentLabelV,strcat(dataSetDir,'trainingLabels',filesep,'Case_',num2str(currentCase),filesep,fNameL))
                        
                       % Display and Save Diagonal
                        %imagesc(currentSection)
                        h2.CData = currentSectionD;
                        title(strcat('D Classes = ',num2str(counterClass_1),'/',num2str(counterClass_2),32,32,'(',num2str(counterR),'-',num2str(counterC),')'))
                        %pause(0.01)
                        drawnow;
                        % Save
                        fName  = strcat('Texture_Randen_Classes_D_',num2str(counterClass_1),'_',num2str(counterClass_2),      'R_',num2str(counterR),'C_',num2str(counterC),'.png');
                        fNameL = strcat('Texture_Randen_Label_Classes_D_',num2str(counterClass_1),'_',num2str(counterClass_2),'R_',num2str(counterR),'C_',num2str(counterC),'.png');
                        imwrite(currentSectionD,strcat(dataSetDir,'trainingImages',filesep,'Case_',num2str(currentCase),filesep,fName))
                        imwrite(currentLabelD,strcat(dataSetDir,'trainingLabels',filesep,'Case_',num2str(currentCase),filesep,fNameL))

                    
                    end
                end
            end
        end
    end
end