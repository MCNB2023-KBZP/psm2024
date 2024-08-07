%% path specification
folder_path_root = '/Users/pschm/icloud_link/University/mcnb/2_semester/PSM-II/psm2024';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_data = fullfile(folder_path_root, 'data');

%% initialization
addpath(spm_path)
addpath(folder_path_root)
spm('defaults', 'fmri') 
spm_jobman('initcfg')

%% specify Parametric empirical Bayes
folder_path_results = fullfile(folder_path_data, 'dcm-group-results');
if ~exist(folder_path_results, 'dir')
    mkdir(folder_path_results);
end

clear job

job{1}.spm.dcm.peb.specify.name = '<UNDEFINED>';
job{1}.spm.dcm.peb.specify.model_space_mat = '<UNDEFINED>';
job{1}.spm.dcm.peb.specify.dcm.index = 1;
job{1}.spm.dcm.peb.specify.cov.none = struct([]);
job{1}.spm.dcm.peb.specify.fields.default = {
                                                     'A'
                                                     'B'
                                                     }';
job{1}.spm.dcm.peb.specify.priors_between.components = 'All';
job{1}.spm.dcm.peb.specify.priors_between.ratio = 16;
job{1}.spm.dcm.peb.specify.priors_between.expectation = 0;
job{1}.spm.dcm.peb.specify.priors_between.var = 0.0625;
job{1}.spm.dcm.peb.specify.priors_glm.group_ratio = 1;
job{1}.spm.dcm.peb.specify.estimation.maxit = 64;
job{1}.spm.dcm.peb.specify.show_review = 0;