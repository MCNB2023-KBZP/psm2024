%% path specification
folder_path_root = '/Users/pschm/icloud_link/University/mcnb/2_semester/PSM-II/psm2024';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_data = fullfile(folder_path_root, 'data');

%% initialization
addpath(spm_path)
addpath(folder_path_root)
spm('defaults', 'fmri') 
spm_jobman('initcfg')

%% specify group and repeat
folder_path_results = fullfile(folder_path_data, 'dcm-group-results');
if ~exist(folder_path_results, 'dir')
    mkdir(folder_path_results);
end

clear job

job{1}.spm.dcm.spec.fmri.group.output.dir = {folder_path_results};
job{1}.spm.dcm.spec.fmri.group.output.name = '<UNDEFINED>';
job{1}.spm.dcm.spec.fmri.group.template.fulldcm = '<UNDEFINED>';
job{1}.spm.dcm.spec.fmri.group.template.altdcm = '';
job{1}.spm.dcm.spec.fmri.group.data.spmmats = '<UNDEFINED>';
job{1}.spm.dcm.spec.fmri.group.data.session = 1;
job{1}.spm.dcm.spec.fmri.group.data.region = {};

spm_jobman('run', job);

%% estimate for all subjects

file_path_gcm = spm_select('FPList', folder_path_results, '^GCM.*\.mat$');

job{1}.spm.dcm.estimate.dcms.gcmmat = {file_path_gcm};
job{1}.spm.dcm.estimate.output.overwrite_gcm = struct([]);
job{1}.spm.dcm.estimate.est_type = 2;
job{1}.spm.dcm.estimate.fmri.analysis = 'time';

spm_jobman('run', job);