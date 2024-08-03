%PPI9

folder_path_root = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024';
spm_path = 'C:\Users\Lenovo\Downloads\spm12';

folder_path_data = fullfile(folder_path_root, 'data.tmp');


subjects = {'sub-001', 'sub-002', 'sub-003','sub-004', 'sub-005', 'sub-006', 'sub-007', 'sub-008', 'sub-009','sub-0010' };
sub_dir = 'C:\Users\Lenovo\Documents\PSM\PPI\data\sub-001';

%% initilization
addpath(spm_path);
addpath(folder_path_root);
spm fmri

%% contrasts
% 
% matlabbatch{1}.spm.stats.con.spmmat = {'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001\1st_level_good_bad_Imag\SPM.mat'};
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'StimNew';
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [2 2 2 0 0 0 -3 -3 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'ImagNew';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [0 0 0 2 2 2 -3 -3 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
% matlabbatch{1}.spm.stats.con.delete = 0;

%% PPI S1 Stim rBA2


% Base ppi code to create ppi file

matlabbatch{1}.spm.stats.ppi.spmmat = {'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001\1st_level_good_bad_Imag\SPM.mat'};
matlabbatch{1}.spm.stats.ppi.type.ppi.voi = {'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001\VOI_rBA2_1.mat'};
matlabbatch{1}.spm.stats.ppi.type.ppi.u = [1 1 1
                                           2 1 1
                                           3 1 1];
matlabbatch{1}.spm.stats.ppi.name = '1Stim_rBA2_ppi';
matlabbatch{1}.spm.stats.ppi.disp = 1;
spm_jobman('run', matlabbatch);

%% PPI S1 Stim SMA

matlabbatch{1}.spm.stats.ppi.spmmat = {'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001\1st_level_good_bad_Imag\SPM.mat'};
matlabbatch{1}.spm.stats.ppi.type.ppi.voi = {'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001\VOI_SMA_1.mat'};
matlabbatch{1}.spm.stats.ppi.type.ppi.u = [1 1 1
                                           2 1 1
                                           3 1 1];
matlabbatch{1}.spm.stats.ppi.name = '1Stim_SMA_PPI';
matlabbatch{1}.spm.stats.ppi.disp = 1;

%% PPI S1 Imag SMA


matlabbatch{1}.spm.stats.ppi.spmmat = {'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001\1st_level_good_bad_Imag\SPM.mat'};
matlabbatch{1}.spm.stats.ppi.type.ppi.voi = {'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001\VOI_SMA_1.mat'};
matlabbatch{1}.spm.stats.ppi.type.ppi.u = [4 1 1
                                           5 1 1
                                           6 1 1];
matlabbatch{1}.spm.stats.ppi.name = '1Imag_SMA_PPI';
matlabbatch{1}.spm.stats.ppi.disp = 1;

%% PPI S1 Imag rBA2


matlabbatch{1}.spm.stats.ppi.spmmat = {'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001\1st_level_good_bad_Imag\SPM.mat'};
matlabbatch{1}.spm.stats.ppi.type.ppi.voi = {'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\sub-001\VOI_rBA2_1.mat'};
matlabbatch{1}.spm.stats.ppi.type.ppi.u = [4 1 1
                                           5 1 1
                                           6 1 1];
matlabbatch{1}.spm.stats.ppi.name = '1Imag_rBA2_PPI';
matlabbatch{1}.spm.stats.ppi.disp = 1;



%% PPI plots

cd 'C:\Users\Lenovo\Documents\PSM\PPI\data_OLD\PPI_results'


SrBA2s1 = load('PPI_1Stim_rBA2_PPI.mat');
IrBA2s1 = load('PPI_1Imag_rBA2_PPI.mat');

SSMAs1 =load('PPI_1Stim_SMA_PPI.mat');
ISMAs1 = load('PPI_1Imag_SMA_PPI.mat');

%%

figure
plot(SrBA2s1.PPI.ppi,SSMAs1.PPI.ppi, 'k.') %stim

hold on
plot(IrBA2s1.PPI.ppi,ISMAs1.PPI.ppi, 'r.') %imag

% Plot for Stim
x = SrBA2s1.PPI.ppi(:);
x = [x, ones(size(x))];
y = SSMAs1.PPI.ppi(:);
B = x\y;
y1 = B(1)*x(:,1) + B(2);
plot(x(:,1), y1, 'k-');
hold on;  % Retain the current plot when adding new plots

% Plot for Imag
x = IrBA2s1.PPI.ppi(:);
x = [x, ones(size(x))];
y = ISMAs1.PPI.ppi(:);
B = x\y;
y1 = B(1)*x(:,1) + B(2);
plot(x(:,1), y1, 'r-');

% Labels, title, and legend
legend('Stim', 'Imag');
xlabel('V2 activity');
ylabel('V5 response');
title('Psychophysiologic Interaction');


%% false plot

plot
x = SrBA2s1.PPI.ppi(:);
x = [x, ones(size(x))];
y = SSMAs1.PPI.ppi(:);
B = x\y;
y1 = B(1)*x(:,1)+B(2);
plot(x(:,1),y1,’k-’);

hold on 
Stim;
x = IrBA2s1.PPI.ppi(:);
x = [x, ones(size(x))];
y = ISMAs1.PPI.ppi(:);
B = x\y;
y1 = B(1)*x(:,1)+B(2);
plot(x(:,1),y1,’r-’);

legend('Stim', 'Imag')
xlabel(’V2 activity’)
ylabel(’V5 response’)
title(’Psychophysiologic Interaction’)


%% glm




%% group lvl




