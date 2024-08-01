%% path specification
folder_path_root = '/Users/pschm/icloud_link/University/mcnb/2_semester/PSM-II/psm2024';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_data = fullfile(folder_path_root, 'data');

%% initialization
addpath(spm_path)
addpath(folder_path_root)
spm('defaults', 'fmri') 
spm_jobman('initcfg')

%% perform model comparison on estimated PEB
folder_path_results = fullfile(folder_path_data, 'dcm-group-results');
if ~exist(folder_path_results, 'dir')
    mkdir(folder_path_results);
end

file_path_PEB = spm('FPList', folder_path_results, '^PEB.*\.mat$');
file_path_GCM = spm('FPList', folder_path_results, '^GCM.*\.mat$');

clear job

job{1}.spm.dcm.peb.compare.peb_mat = {file_path_PEB}; % PEB file here
job{1}.spm.dcm.peb.compare.model_space_mat = {file_path_GCM}; % GCM file here
job{1}.spm.dcm.peb.compare.show_review = 1;

%job{1}.spm.dcm.bms.inference.dir = {folder_path_results};
%job{1}.spm.dcm.bms.inference.sess_dcm = {};
%job{1}.spm.dcm.bms.inference.model_sp = {''}; % put PEB here
%job{1}.spm.dcm.bms.inference.load_f = {''};
%job{1}.spm.dcm.bms.inference.method = '<UNDEFINED>';
%job{1}.spm.dcm.bms.inference.family_level.family_file = {''};
%job{1}.spm.dcm.bms.inference.bma.bma_no = 0;
%job{1}.spm.dcm.bms.inference.verify_id = 1;

spm_jobman('run', run);
