folder_path_root = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp';
spm_path = 'C:\Users\Lenovo\Downloads\spm12';

% folder_path_data = fullfile(folder_path_root, 'data.tmp');


subjects = {'sub-001', 'sub-002', 'sub-003','sub-004', 'sub-005', 'sub-006', 'sub-007', 'sub-008', 'sub-009','sub-0010' };
sub_dir = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\sub-001';

%% initilization
addpath(spm_path);
addpath(folder_path_root);
spm fmri

%% S1 Stim rBA2 

% [1 1 1
% 2 1 1
% 3 1 1]

cd 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\sub-003\1st_level_good_bad_Imag';


%% S2 Imag
% 
% matlabbatch{1}.spm.stats.ppi.spmmat = {'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\sub-002\1st_level_good_bad_Imag\SPM.mat'};
% matlabbatch{1}.spm.stats.ppi.type.ppi.voi = {'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\sub-002\1st_level_good_bad_Imag\VOI_rSII_1.mat'};
% matlabbatch{1}.spm.stats.ppi.type.ppi.u = [4 1 1
%                                            5 1 1
%                                            6 1 1];
% matlabbatch{1}.spm.stats.ppi.name = 'S2ImagrSII';
% matlabbatch{1}.spm.stats.ppi.disp = 0;

%% new














