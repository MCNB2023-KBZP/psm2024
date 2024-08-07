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
folder_path_results = fullfile(folder_path_root, 'data.tmp', 'dcm-group-results');
if ~exist(folder_path_results, 'dir')
    mkdir(folder_path_results);
end

%% extract parameter estimates
sub_all = [1 2 3 5 6 7]; % 4 8 9 10
model = 5;

% DCM.a                              % switch on endogenous connections
% DCM.b                              % switch on bilinear modulations
% DCM.c                              % switch on exogenous connections
% DCM.d                              % switch on nonlinear modulations
% DCM.U                              % exogenous inputs
% DCM.Y.y                            % responses
% DCM.Y.X0                           % confounds
% DCM.Y.Q                            % array of precision components
% DCM.n                              % number of regions
% DCM.v                              % number of scansparameter_estimates = [];


parameter_estimates = cell(numel(sub_all),5);
for si=1:numel(sub_all)
    s = sub_all(si);
    folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s), '1st_level_new_reduced');
    folder_path_models = fullfile(folder_path_sub, 'DCM_Models');
    pattern = sprintf('^DCM_Model_%d.mat$', model);
    file_path_model= spm_select('FPList', folder_path_models, pattern);
    load(file_path_model, 'DCM');
    
    parameter_estimates(si, 1) = {reshape(DCM.Ep.A.',1,[])}; % endogeneuous 
    parameter_estimates(si, 2) = {reshape(DCM.Ep.B(:,:,1).',1,[])}; % stimulation modulatory
    parameter_estimates(si, 3) = {reshape(DCM.Ep.B(:,:,2).',1,[])}; % imagery modulatory
    parameter_estimates(si, 4) = {reshape(DCM.Ep.C(:,1).',1,[])}; % exo stim
    parameter_estimates(si, 5) = {reshape(DCM.Ep.C(:,2).',1,[])}; % exo imag
end

%% perform t-test
test_results = cell(1, 5);
for i=1:size(parameter_estimates,2)
    parameter_estimates_type = parameter_estimates(:,i);
    parameter_estimates_type_mat = cell2mat(parameter_estimates_type);
    p_vec = [];

    for j=1:size(parameter_estimates_type_mat,2)
        
        testing = parameter_estimates_type_mat(:,j);
        %[h, p, ci, stats] = ttest(parameter_estimates);
        [~,p,~,~] = ttest(testing);
        p_vec = [p_vec p];
    end
    test_results(i) = {p_vec};
end

%% FDR correction
test_results_corrected = [];
for t=1:numel(test_results)
    test_results_corrected{t} = fdr_bh(test_results{t}, 0.05, 'dep','yes');
end

%% clean up
rmpath(genpath(folder_path_root))