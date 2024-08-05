%% path specification
folder_path_root = '/Users/pschm/icloud_link/University/mcnb/2_semester/PSM-II/psm2024-local/dcm_bms';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_data = fullfile(folder_path_root, 'dcm-base-files');

%% initialization
addpath(spm_path)
addpath(folder_path_root)
spm('defaults', 'fmri') 
spm_jobman('initcfg')

%% create dcm-group folder
folder_path_results = fullfile(folder_path_data, 'dcm-group-results');
if ~exist(folder_path_results, 'dir')
    mkdir(folder_path_results);
end

%% FFX specify batch
clear job

sub_all = 1:12;
models_all = 1:16;

job{1}.spm.dcm.bms.inference.dir = {folder_path_results};
job{1}.spm.dcm.bms.inference.model_sp = {''};
job{1}.spm.dcm.bms.inference.load_f = {''};
job{1}.spm.dcm.bms.inference.method = 'RFX';
job{1}.spm.dcm.bms.inference.family_level.family_file = {''};
job{1}.spm.dcm.bms.inference.bma.bma_no = 0;
job{1}.spm.dcm.bms.inference.verify_id = 1;

for s=sub_all
    %folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));
    folder_path_sub = fullfile(folder_path_data, sprintf('subject%d',s));
    %folder_path_models = fullfile(folder_path_sub, '1st_level_good_bad_Imag');
    folder_path_models = folder_path_sub;
    %pattern = ['^DCM_(', strjoin(arrayfun(@num2str, models_all, 'UniformOutput', false), '|'), ')\.mat$'];
    %file_path_models = spm_select('FPList', folder_path_models, pattern);
    %job{1}.spm.dcm.bms.inference.sess_dcm{s}.dcmmat = cellstr(file_path_models);
    
    file_path_models = [];
    for m=models_all
        pattern = sprintf('^DCM_%d.mat$', m);
        file_path_models{m} = spm_select('FPList', folder_path_models, pattern);
    end
    
    file_path_models = transpose(file_path_models);
    job{1}.spm.dcm.bms.inference.sess_dcm{s}.dcmmat = file_path_models;
end

spm_jobman('run', job)
