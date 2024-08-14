%% path specification

folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp'
spm_path = 'C:\Users\Lenovo\Downloads\spm12'

%% initialization
addpath(spm_path)
%addpath(folder_path_data)
spm('defaults', 'fmri') 
spm_jobman('initcfg')

%% Imag

sub_all = 1:10;
roi_all = {'IIPL'};

for s=sub_all

    folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));
    file_path_SPMmat = fullfile(folder_path_sub, '1st_level_good_bad_Imag', 'SPM.mat');
    folder_path_roi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');
    pattern = ['^VOI_.*(', strjoin(roi_all, '|'), ').*\.mat$'];

    file_path_ROI = spm_select('FPList', folder_path_roi, pattern);

    clear job
    
    job{1}.spm.stats.ppi.spmmat = {file_path_SPMmat};
    job{1}.spm.stats.ppi.type.ppi.voi = cellstr(file_path_ROI);
    job{1}.spm.stats.ppi.type.ppi.u = [2 1 1];
    job{1}.spm.stats.ppi.name = 'Imag_IIPL'; %
    job{1}.spm.stats.ppi.disp = 0;
    
    spm_jobman('run', job)
end


%% 

clear
clc


%% rIFG

%% path specification

% folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp'
% spm_path = 'C:\Users\Lenovo\Downloads\spm12'

% %% initialization
% addpath(spm_path)
% %addpath(folder_path_data)
% spm('defaults', 'fmri') 
% spm_jobman('initcfg')
% 
% 
% 
% sub_all = 1:10;
% roi_all = {'rBA3b'};
% 
% for s=sub_all
% 
%     folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));
%     file_path_SPMmat = fullfile(folder_path_sub, '1st_level_good_bad_Imag', 'SPM.mat');
%     folder_path_roi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');
%     pattern = ['^VOI_.*(', strjoin(roi_all, '|'), ').*\.mat$'];
% 
%     file_path_ROI = spm_select('FPList', folder_path_roi, pattern);
% 
%     clear job
% 
%     job{1}.spm.stats.ppi.spmmat = {file_path_SPMmat};
%     job{1}.spm.stats.ppi.type.ppi.voi = cellstr(file_path_ROI);
%     job{1}.spm.stats.ppi.type.ppi.u = [2 1 1];
%     job{1}.spm.stats.ppi.name = 'Imag_rBA3b'; %
%     job{1}.spm.stats.ppi.disp = 0;
% 
%     spm_jobman('run', job)
% end
% 
% 
% clear
% clc
% 
% 


