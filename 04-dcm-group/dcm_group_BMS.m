%% path specification
folder_path_root = '/Users/pschm/icloud_link/University/mcnb/2_semester/PSM-II/psm2024';
spm_path = '/Users/pschm/spm12_dev_main';
%folder_path_data = fullfile(folder_path_root, 'dcm-base-files');
folder_path_data = '/Users/pschm/fubox/psm2024-time-series-reduced';

%% initialization
addpath(spm_path)
addpath(genpath(folder_path_root))
spm('defaults', 'fmri') 
spm_jobman('initcfg')

%% create dcm-group folder
%folder_path_results = fullfile(folder_path_data, 'dcm-group-results');
folder_path_results = fullfile(folder_path_root, 'data.tmp', 'dcm-group-results');
if ~exist(folder_path_results, 'dir')
    mkdir(folder_path_results);
end

%% RFX specify batch
ready=1;
clear job

%sub_all = [1 2 3 5 6 7]; % 4 8 9 10
sub_all = [1 2 4 5 6 7 8 9 10];
models_all = 1:6;

job{1}.spm.dcm.bms.inference.dir = {folder_path_results};
job{1}.spm.dcm.bms.inference.model_sp = {''};
job{1}.spm.dcm.bms.inference.load_f = {''};
job{1}.spm.dcm.bms.inference.method = 'RFX';
job{1}.spm.dcm.bms.inference.family_level.family_file = {''};
%job{1}.spm.dcm.bms.inference.bma.bma_yes.bma_famwin = 'famwin';
job{1}.spm.dcm.bms.inference.bma.bma_no = 0;
job{1}.spm.dcm.bms.inference.verify_id = 1;

for si=1:numel(sub_all)
    s = sub_all(si);
    folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s), '1st_level_new_reduced');
    folder_path_models = fullfile(folder_path_sub, 'DCM_Models');
    
    %pattern = ['^DCM_(', strjoin(arrayfun(@num2str, models_all, 'UniformOutput', false), '|'), ')\.mat$'];
    %file_path_models = spm_select('FPList', folder_path_models, pattern);
    %job{1}.spm.dcm.bms.inference.sess_dcm{s}.dcmmat = cellstr(file_path_models);
    
    file_path_models = [];
    for m=models_all
        pattern = sprintf('^DCM_Model_%d.mat$', m);
        file_path_models{m} = spm_select('FPList', folder_path_models, pattern);


        load(file_path_models{m})
        if ~(strcmp(DCM.xY(1).name, 'rBA2') & strcmp(DCM.xY(2).name, 'rSII') & strcmp(DCM.xY(3).name, 'SMA'))
            warning(sprintf('Order of VOIs of model %d of subject %d is incorrect', m, s))
            ready=0;
        end
        
    end
    
    file_path_models = transpose(file_path_models);
    job{1}.spm.dcm.bms.inference.sess_dcm{si}.dcmmat = file_path_models;
end


if ready
    spm_jobman('run', job)
else
    warning('spm_jobman did not run. Check warnings.')
end
