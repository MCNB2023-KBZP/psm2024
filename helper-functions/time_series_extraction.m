%% path specification
folder_path_root = '/Users/pschm/icloud_link/University/mcnb/2_semester/PSM-II/psm2024';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_data = fullfile(folder_path_root, 'data.tmp');
folder_path_cloud = '/Users/pschm/fubox/psm2024-time-series';

%% initialization
addpath(spm_path)
addpath(folder_path_root)
spm('defaults', 'fmri') 
spm_jobman('initcfg')



%% subject
sub_all = [1 2 3 4 5 6 7 8 9 10];

for s=sub_all

    folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));
    %file_path_SPMmat = fullfile(folder_path_sub, '1st_level_good_bad_Imag', 'SPM.mat');
    file_path_SPMmat = fullfile(folder_path_sub, '1st_level_new', 'SPM.mat');
    
    %% define contrasts
    clear job;
    
    job{1}.spm.stats.con.spmmat = {file_path_SPMmat};
    
    % Conjunction
    job{1}.spm.stats.con.consess{1}.tcon.name = 'Stimulation > Null 1 Conj';
    job{1}.spm.stats.con.consess{1}.tcon.weights = [1 1 1 0 0 0 -3 0 repelem(0,3)];
    job{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    
    job{1}.spm.stats.con.consess{2}.tcon.name = 'Imagery > Null 2 Conj';
    job{1}.spm.stats.con.consess{2}.tcon.weights = [0 0 0 1 1 1 0 -3 repelem(0,3)];
    job{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

    job{1}.spm.stats.con.consess{3}.fcon.name = 'Effects Stim Imag Conj';
    job{1}.spm.stats.con.consess{3}.fcon.weights = [eye(8) repelem(0,8,3)];
    job{1}.spm.stats.con.consess{3}.fcon.sessrep = 'none';

    % Stim vs Null
    job{1}.spm.stats.con.consess{4}.tcon.name = 'Stimulation > Null';
    job{1}.spm.stats.con.consess{4}.tcon.weights = [2 2 2 0 0 0 -3 -3 repelem(0,3)];
    job{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
    
    job{1}.spm.stats.con.consess{5}.fcon.name = 'Effects Stim > NULL';
    I = eye(8);
    I(:,4:6) = 0;
    job{1}.spm.stats.con.consess{5}.fcon.weights = [I repelem(0,8,3)];
    job{1}.spm.stats.con.consess{5}.fcon.sessrep = 'none';
    
    % further F contrast
    %job{1}.spm.stats.con.consess{6}.fcon.name = 'F Stim';
    %job{1}.spm.stats.con.consess{6}.fcon.weights = [eye(3) repelem(0,3,8)];
    %job{1}.spm.stats.con.consess{6}.fcon.sessrep = 'none';
    
    %job{1}.spm.stats.con.consess{7}.fcon.name = 'F Imag';
    %job{1}.spm.stats.con.consess{7}.fcon.weights = [repelem(0,3,3) eye(3) repelem(0,3,5)];
    %job{1}.spm.stats.con.consess{7}.fcon.sessrep = 'none';

    %job{1}.spm.stats.con.consess{8}.fcon.name = 'F Stim and Imag';
    %job{1}.spm.stats.con.consess{8}.fcon.weights = [eye(6) repelem(0,6,5)];
    %job{1}.spm.stats.con.consess{8}.fcon.sessrep = 'none';


    job{1}.spm.stats.con.delete = 1;
    
    % run batch
    spm_jobman('run',job);
    
    %% extract ROI
    folder_path_preROI = fullfile(folder_path_data, 'rois');
    file_path_preROI = cellstr(spm_select('FPList', folder_path_preROI, '^.*\.nii$'));
    
    roi_names = {'rBA2', 'lIPL', 'SMA', 'rIFG', 'lIFG', 'rBA1', 'rBA2_2', 'rBA3b', 'lSII', 'rSII'};
    %roi_contrast_set = [1 1 1 1 1 2 2 2 2 2];
    roi_contrast_set = repelem(2,10);

    for i=1:numel(file_path_preROI)
        
        clear job;
        
        job{1}.spm.util.voi.spmmat = {file_path_SPMmat};
        job{1}.spm.util.voi.session = 1;
        job{1}.spm.util.voi.name = roi_names{i};
        
        % get voxels
        job{1}.spm.util.voi.roi{1}.spm.spmmat = {file_path_SPMmat};

        if roi_contrast_set(i) == 1
            job{1}.spm.util.voi.roi{1}.spm.contrast = [1 2];
            job{1}.spm.util.voi.roi{1}.spm.conjunction = 1;
            job{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
            job{1}.spm.util.voi.roi{1}.spm.thresh = 0.001;

            % adjust
            job{1}.spm.util.voi.adjust = 3;
        else
            job{1}.spm.util.voi.roi{1}.spm.contrast = 4;
            job{1}.spm.util.voi.roi{1}.spm.conjunction = 1;
            job{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
            job{1}.spm.util.voi.roi{1}.spm.thresh = 0.001;

            % adjust
            job{1}.spm.util.voi.adjust = 5;
        end

        job{1}.spm.util.voi.roi{1}.spm.extent = 0;
        job{1}.spm.util.voi.roi{1}.spm.mask = struct('contrast', {}, 'thresh', {}, 'mtype', {});
        
        % predefined mask
        job{1}.spm.util.voi.roi{2}.mask.image = {file_path_preROI{i}};
        job{1}.spm.util.voi.roi{2}.mask.threshold = 0.5;
        
        % define sphere
        job{1}.spm.util.voi.roi{3}.sphere.centre = [0 0 0];
        job{1}.spm.util.voi.roi{3}.sphere.radius = 8;
        job{1}.spm.util.voi.roi{3}.sphere.move.global.spm = 1;
        job{1}.spm.util.voi.roi{3}.sphere.move.global.mask = 'i2';
        job{1}.spm.util.voi.expression = 'i1 & i2 & i3';
        
        % run batch
        spm_jobman('run',job);
    end

    
    % move to cloud
    folder_path_cloud_sub = fullfile(folder_path_cloud,  sprintf('sub-%03d',s));

    if ~exist(folder_path_cloud_sub, 'dir')
        mkdir(folder_path_cloud_sub);
    end

    file_path_VOI = cellstr(spm_select('FPList', fullfile(folder_path_sub, '1st_level_new'), '^VOI_.*\.mat$'));

    for f=1:numel(file_path_VOI)
        copyfile(file_path_VOI{f}, folder_path_cloud_sub)
    end

end % subject loop