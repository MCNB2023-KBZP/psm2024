datadir = '/Users/kaseydevitt/Downloads/'; % the folder where you downloaded the data
cd(datadir)

spmdir = '/Users/kaseydevitt/MATLAB/spm12'; % your SPM folder
addpath(spmdir)
spm fmri

% Load the onsets and condition names from the MAT file
mat_file = 'sub-001/all_onsets_goodImag_sub001.mat';
data = load(mat_file);
conditions = data.condnames;
onsets = data.onsets;

% List of fMRI data files
fmri_files = {
    '/mnt/data/rPSC_1_TR50_right_CUT_Stim_vs_Null.nii',
    '/mnt/data/rPSC_2_TR50_right_CUT_Stim_vs_Null.nii',
    '/mnt/data/rPSC_3b_TR50_right_CUT_Stim_vs_Null.nii',
    '/mnt/data/rSII_TR50_left_CUT_Stim_vs_Null.nii',
    '/mnt/data/rSII_TR50_right_CUT_Stim_vs_Null.nii'
};

% List of ROI masks
roi_files = {
    '/mnt/data/1CONJ_right_BA2_uncorr.nii',
    '/mnt/data/2CONJ_left_IPL_uncorr.nii',
    '/mnt/data/3CONJ_SMA_uncorr.nii',
    '/mnt/data/4CONJ_right_IFG_uncorr.nii',
    '/mnt/data/5CONJ_left_IFG_uncorr.nii'
};

% Load ROI masks and extract voxel indices
roi_indices = cell(length(roi_files), 1);
for i = 1:length(roi_files)
    M = spm_vol(roi_files{i});
    roi = spm_read_vols(M);
    roi_indices{i} = find(roi > 0);
end

% Prepare features and labels
features = [];
labels = [];
condition_indices = find(strcmp(conditions, {'StimPress', 'StimFlutt', 'StimVibro'}));

% Load fMRI data, extract time-series data from ROIs
for k = 1:length(fmri_files)
    V = spm_vol(fmri_files{k});
    Y = spm_read_vols(V);
    
    % Loop through conditions and onsets
    for i = 1:length(condition_indices)
        condition_onsets = onsets{condition_indices(i)};
        
        for j = 1:length(condition_onsets)
            onset_time = condition_onsets(j);
            
            % Ensure the onset time aligns with the data dimensions
            if onset_time > size(Y, 4)
                warning('Onset time exceeds data dimensions. Skipping...');
                continue;
            end
            
            % Extract voxel data for this onset across all ROIs
            voxel_data = [];
            for m = 1:length(roi_indices)
                voxel_data = [voxel_data; Y(roi_indices{m} + onset_time - 1)];
            end
            
            % Collect data
            features = [features; voxel_data'];
            labels = [labels; i];  % Label based on condition index
        end
    end
end

% Perform classification using Linear Discriminant Analysis (LDA)
lda_model = fitcdiscr(features, labels);

% Cross-validation
cv = cvpartition(labels, 'KFold', 5);
lda_cv_model = crossval(lda_model, 'CVPartition', cv);

% Classification accuracy
lda_accuracy = 1 - kfoldLoss(lda_cv_model);

disp(['LDA Classification Accuracy: ', num2str(lda_accuracy)])
