%% ppi rBA1 Imag seed
% this was my original script for how to do PPI for every region
% as my loop did not work, before using the help of 
% the SPM manual and chatgpt to do the loop script



%% initialization

spm_path = 'C:\Users\Lenovo\Downloads\spm12';
addpath(spm_path);
%addpath(folder_path_data)
spm('defaults', 'fmri'); 
spm_jobman('initcfg');
%spm;

%% code here - loop over subjects, for Imag ppi seed (rBA1) to  rBA2

sub_all = [1, 2, 4, 5, 6, 7, 9, 10];

folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp';
spm_path = 'C:\Users\Lenovo\Downloads\spm12';

% regions = {'rBA1', 'rBA2' 'rBA3b', 'rIFG', 'rSII', 'SMA'};

for s=sub_all

ppi_1 = {'rBA1'};
roi_all = {'rBA2'};


folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));

folder_path_roi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

folder_path_ppi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

% ...VOI_xregion_1   - same ending every subject
%pattern = ['^VOI_.*(', strjoin(roi_all, '|'), ').*\.mat$'];

pattern = ['VOI_rBA2_1.mat'];

% ...PPI_Imag_x_S1 - subject 1, changing

ppi_s = cellstr (ppi_1);

pattern_ppi = sprintf('PPI_Imag_rBA1_S%d.mat', s);

%pattern_ppi2 = cellstr(pattern_ppi); % CONVERT TO CELL FOR PATH BC pattern_ppi not one string?


file_path_VOI2 = fullfile(folder_path_roi, pattern);

file_path_ppi2 = fullfile(folder_path_ppi, pattern_ppi);

%clear 'FPList'
%clear spm_select

 load(file_path_ppi2);
    Xglm = PPI.ppi;

 load(file_path_VOI2, 'Y');
    Yglm = Y;

    [betas, ~, stats] = glmfit(Xglm, Yglm);

cd (folder_path_roi)

save_filen = sprintf('PPI_Imag_rBA1_rBA2_glmS%d.mat', s);
save(fullfile(folder_path_roi, save_filen), 'betas', 'stats');

%spm_jobman('run', job)
% clear(matlabbatch)

end

% clear
% clc
%%

%% code here - loop over subjects, for Imag ppi seed (rBA1) to  rBA3b

sub_all = [1, 2, 4, 5, 6, 7, 9, 10];

folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp';
spm_path = 'C:\Users\Lenovo\Downloads\spm12';


for s=sub_all

ppi_1 = {'rBA1'};
roi_all = {'rBA3b'};


folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));

folder_path_roi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

folder_path_ppi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

% ...VOI_xregion_1   - same ending every subject
%pattern = ['^VOI_.*(', strjoin(roi_all, '|'), ').*\.mat$'];

pattern = ['VOI_rBA3b_1.mat'];

% ...PPI_Imag_x_S1 - subject 1, changing

ppi_s = cellstr (ppi_1);

pattern_ppi = sprintf('PPI_Imag_rBA1_S%d.mat', s);

%pattern_ppi2 = cellstr(pattern_ppi); % CONVERT TO CELL FOR PATH BC pattern_ppi not one string?


file_path_VOI2 = fullfile(folder_path_roi, pattern);

file_path_ppi2 = fullfile(folder_path_ppi, pattern_ppi);

%clear 'FPList'
%clear spm_select

 load(file_path_ppi2);
    Xglm = PPI.ppi;

 load(file_path_VOI2, 'Y');
    Yglm = Y;

    [betas, ~, stats] = glmfit(Xglm, Yglm);

cd (folder_path_roi)

save_filen = sprintf('PPI_Imag_rBA1_rBA3b_glmS%d.mat', s);
save(fullfile(folder_path_roi, save_filen), 'betas', 'stats');

%spm_jobman('run', job)
% clear(matlabbatch)

end

% clear
% clc
%%

%% code here - loop over subjects, for Imag ppi seed (rBA1) to  rSII

sub_all = [1, 2, 4, 5, 6, 7, 9, 10];

folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp';
spm_path = 'C:\Users\Lenovo\Downloads\spm12';


for s=sub_all

ppi_1 = {'rBA1'};
roi_all = {'rSII'};


folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));

folder_path_roi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

folder_path_ppi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

% ...VOI_xregion_1   - same ending every subject
%pattern = ['^VOI_.*(', strjoin(roi_all, '|'), ').*\.mat$'];

pattern = ['VOI_rSII_1.mat'];

% ...PPI_Imag_x_S1 - subject 1, changing

ppi_s = cellstr (ppi_1);

pattern_ppi = sprintf('PPI_Imag_rBA1_S%d.mat', s);

%pattern_ppi2 = cellstr(pattern_ppi); % CONVERT TO CELL FOR PATH BC pattern_ppi not one string?


file_path_VOI2 = fullfile(folder_path_roi, pattern);

file_path_ppi2 = fullfile(folder_path_ppi, pattern_ppi);

%clear 'FPList'
%clear spm_select

 load(file_path_ppi2);
    Xglm = PPI.ppi;

 load(file_path_VOI2, 'Y');
    Yglm = Y;

    [betas, ~, stats] = glmfit(Xglm, Yglm);

cd (folder_path_roi)

save_filen = sprintf('PPI_Imag_rBA1_rSII_glmS%d.mat', s);
save(fullfile(folder_path_roi, save_filen), 'betas', 'stats');

%spm_jobman('run', job)
% clear(matlabbatch)

end

% clear
% clc
%%

%% ppi glm pv 4


%% initialization

% spm_path = 'C:\Users\Lenovo\Downloads\spm12';
% addpath(spm_path);
% %addpath(folder_path_data)
% spm('defaults', 'fmri'); 
% spm_jobman('initcfg');
% spm;

%% code here - loop over subjects, for Imag ppi seed (rBA1) to  rIFG

sub_all = [1, 2, 4, 5, 6, 7, 9, 10];

folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp';
spm_path = 'C:\Users\Lenovo\Downloads\spm12';


for s=sub_all

ppi_1 = {'rBA1'};
roi_all = {'rIFG'};


folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));

folder_path_roi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

folder_path_ppi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

% ...VOI_xregion_1   - same ending every subject
%pattern = ['^VOI_.*(', strjoin(roi_all, '|'), ').*\.mat$'];

pattern = ['VOI_rIFG_1.mat'];

% ...PPI_Imag_x_S1 - subject 1, changing

ppi_s = cellstr (ppi_1);

pattern_ppi = sprintf('PPI_Imag_rBA1_S%d.mat', s);

%pattern_ppi2 = cellstr(pattern_ppi); % CONVERT TO CELL FOR PATH BC pattern_ppi not one string?


file_path_VOI2 = fullfile(folder_path_roi, pattern);

file_path_ppi2 = fullfile(folder_path_ppi, pattern_ppi);

%clear 'FPList'
%clear spm_select

 load(file_path_ppi2);
    Xglm = PPI.ppi;

 load(file_path_VOI2, 'Y');
    Yglm = Y;

    [betas, ~, stats] = glmfit(Xglm, Yglm);

cd (folder_path_roi)

save_filen = sprintf('PPI_Imag_rBA1_rIFG_glmS%d.mat', s);
save(fullfile(folder_path_roi, save_filen), 'betas', 'stats');

%spm_jobman('run', job)
% clear(matlabbatch)

end

% clear
% clc

%%

%% code here - loop over subjects, for Imag ppi seed (rBA1) to  SMA

sub_all = [1, 2, 4, 5, 6, 7, 9, 10];

folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp';
spm_path = 'C:\Users\Lenovo\Downloads\spm12';


for s=sub_all

ppi_1 = {'rBA1'};
roi_all = {'SMA'};


folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));

folder_path_roi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

folder_path_ppi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

% ...VOI_xregion_1   - same ending every subject
%pattern = ['^VOI_.*(', strjoin(roi_all, '|'), ').*\.mat$'];

pattern = ['VOI_SMA_1.mat'];

% ...PPI_Imag_x_S1 - subject 1, changing

ppi_s = cellstr (ppi_1);

pattern_ppi = sprintf('PPI_Imag_rBA1_S%d.mat', s);

%pattern_ppi2 = cellstr(pattern_ppi); % CONVERT TO CELL FOR PATH BC pattern_ppi not one string?


file_path_VOI2 = fullfile(folder_path_roi, pattern);

file_path_ppi2 = fullfile(folder_path_ppi, pattern_ppi);

%clear 'FPList'
%clear spm_select

 load(file_path_ppi2);
    Xglm = PPI.ppi;

 load(file_path_VOI2, 'Y');
    Yglm = Y;

    [betas, ~, stats] = glmfit(Xglm, Yglm);

cd (folder_path_roi)

save_filen = sprintf('PPI_Imag_rBA1_SMA_glmS%d.mat', s);
save(fullfile(folder_path_roi, save_filen), 'betas', 'stats');

%spm_jobman('run', job)
% clear(matlabbatch)

end

% clear
% clc