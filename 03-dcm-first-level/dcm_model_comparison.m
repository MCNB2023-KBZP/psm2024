%% path specification
folder_path_root = '/Users/pschm/icloud_link/University/mcnb/2_semester/PSM-II/psm2024';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_data = fullfile(folder_path_root, 'data');

%% initialization
addpath(spm_path)
addpath(folder_path_root)
spm('defaults', 'fmri') 
spm_jobman('initcfg')

%% specify batch
clear job

sub_all = [1 2 3 4 5 6 7 8 9 10];
models_all = [1 2];


for s=sub_all
    
    folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));
    folder_path_results = fullfile(folder_path_sub, '1st_level_good_bad_Imag');
    pattern = ['^DCM_(', strjoin(arrayfun(@num2str, models_all, 'UniformOutput', false), '|'), ')\.mat$'];
    file_path_models = spm_select('FPList', folder_path_results, pattern);

    job{1}.spm.dcm.bms.inference.dir = {folder_path_results};
    job{1}.spm.dcm.bms.inference.sess_dcm{1}.dcmmat = cellstr(file_path_models);
    job{1}.spm.dcm.bms.inference.model_sp = {''};
    job{1}.spm.dcm.bms.inference.load_f = {''};
    job{1}.spm.dcm.bms.inference.method = 'FFX';
    job{1}.spm.dcm.bms.inference.family_level.family_file = {''};
    job{1}.spm.dcm.bms.inference.bma.bma_no = 0;
    job{1}.spm.dcm.bms.inference.verify_id = 1;

    spm_jobman('run', job)

end