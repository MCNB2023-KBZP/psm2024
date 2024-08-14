%% initialization
spm_path = 'C:\Users\Lenovo\Downloads\spm12';
addpath(spm_path);
spm('defaults', 'fmri'); 
spm_jobman('initcfg');

%% Define subjects and regions
sub_all = [1, 2, 4, 5, 6, 7, 9, 10];
folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp';
conditions = {'Imag', 'Stim'}; % Add your conditions here

ppi_seeds = {'rBA1', 'rBA2', 'rBA3b', 'rIFG', 'rSII', 'SMA'}; % Define PPI seeds
roi_all = {'rBA1', 'rBA2', 'rBA3b', 'rIFG', 'rSII', 'SMA'};  % Define regions

%% Loop over subjects, conditions, PPI seeds, and regions
for s = sub_all
    for cond = conditions
        for ppi_1 = ppi_seeds
            for roi = roi_all
                if strcmp(ppi_1, roi)
                    % Skip same seed and target region pair
                    continue;
                end
                
                folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d', s));
                folder_path_cond = fullfile(folder_path_sub, ['1st_level_good_bad_' char(cond)]);
                
                % Define PPI file path
                pattern_ppi = sprintf('PPI_%s_%s_S%d.mat', char(cond), char(ppi_1), s);
                file_path_ppi = fullfile(folder_path_cond, pattern_ppi);
                
                % Define VOI file path
                pattern_roi = sprintf('VOI_%s_1.mat', char(roi));
                file_path_VOI = fullfile(folder_path_cond, pattern_roi);
                
                % Load data
                load(file_path_ppi);
                Xglm = PPI.ppi;

                load(file_path_VOI, 'Y');
                Yglm = Y;

                % Compute GLM
                [betas, ~, stats] = glmfit(Xglm, Yglm);

                % Save results
                save_filen = sprintf('PPI_%s_%s_%s_glmS%d.mat', char(cond), char(ppi_1), char(roi), s);
                save(fullfile(folder_path_cond, save_filen), 'betas', 'stats');
            end
        end
    end
end

% clear
% clc
