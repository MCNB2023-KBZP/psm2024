%% GLM group 2
% this is the script for when you want to get group lvl results
% for a certain PPI regions - I did it for all regions

% Define the path to the folder
folderPath = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\GLMs_indi\rBA2';

% List of participants
subs = {'S1', 'S2', 'S4', 'S5', 'S6', 'S7', 'S9', 'S10'};

% Initialize an empty array to store the betas
betasArray = [];

% Loop over each participant
for i = 1:length(subs)
    % Create the filename for the current participant
    fileName = sprintf('PPI_Imag_rBA2_rBA1_glm%s.mat', subs{i});
    
    % Create the full path to the file
    filePath = fullfile(folderPath, fileName);
    
    % Load the .mat file
    data = load(filePath);
    
    % Extract the second row's first value from the 'betas' variable
    betaValue = data.betas(2, 1); % Assuming 'betas' is a matrix
    
    % Append the beta value to the array
    betasArray = [betasArray; betaValue];
end

% Create a table with the beta values
rBA2_rBA1 = table(betasArray, 'VariableNames', {'BetaValue'});

% Display the table
disp(rBA2_rBA1);






%% spm fmri
% 
% folder_rBA2 = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\GLMs_indi\rBA2';
% 
% % predict rBA1
% 
% load('PPI_Imag_rBA2_rBA1_glmS1.mat')
% 
% table_rBA1 = [];







