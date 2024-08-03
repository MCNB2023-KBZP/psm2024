%% paths


folder_path_root = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024';
spm_path = 'C:\Users\Lenovo\Downloads\spm12';

folder_path_data = fullfile(folder_path_root, 'data.tmp');


subjects = {'sub-001', 'sub-002', 'sub-003','sub-004', 'sub-005', 'sub-006', 'sub-007', 'sub-008', 'sub-009','sub-0010' };
sub_dir = 'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001';

%% initilization
addpath(spm_path);
addpath(folder_path_root);
spm fmri



%% loop try Stim rBA2

subjects = {'sub-001', 'sub-002', 'sub-003','sub-004', 'sub-005', 'sub-006', 'sub-007', 'sub-008', 'sub-009','sub-0010' };

for i=1:length(subjects)

folder_path_newd = 'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD'; %data folder

folder_curr_sub = fullfile(folder_path_newd, subjects{i}); %current subject folder

file_path_SPM = fullfile(folder_curr_sub, '1st_level_good_bad_Imag', 'SPM.mat');

file_path_VOI = fullfile(folder_curr_sub, 'VOI_rBA2_1.mat')

sub = i;

matlabbatch{1}.spm.stats.ppi.spmmat = {'file_path_SPM'};
matlabbatch{1}.spm.stats.ppi.type.ppi.voi = {file_path_VOI'};
matlabbatch{1}.spm.stats.ppi.type.ppi.u = [1 1 1
                                           2 1 1
                                           3 1 1];
matlabbatch{1}.spm.stats.ppi.name = sprintf('%dStim_rBA2_ppi', sub);
matlabbatch{1}.spm.stats.ppi.disp = 1;

clear matlabbatch;

end





