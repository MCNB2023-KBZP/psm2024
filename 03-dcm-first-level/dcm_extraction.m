%% path specification
folder_path_root = '/Users/pschm/icloud_link/University/mcnb/2_semester/PSM-II/psm2024';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_data = fullfile(folder_path_root, 'data');

%% initialization
addpath(spm_path)
addpath(folder_path_root)
spm('defaults', 'fmri') 
spm_jobman('initcfg')

%% subject
for s=1:10

    folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));
    file_path_SPMmat = fullfile(folder_path_sub, '1st_level_good_bad_Imag', 'SPM.mat');
    
    %% define contrasts
    clear job;
    
    job{1}.spm.stats.con.spmmat = {file_path_SPMmat};
    
    job{1}.spm.stats.con.consess{1}.tcon.name = 'Stimulation > Null';
    job{1}.spm.stats.con.consess{1}.tcon.weights = [2 2 2 0 0 0 -3 -3 repelem(0,3)];
    job{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    
    job{1}.spm.stats.con.consess{2}.fcon.name = 'Effects of interest';
    I = eye(8);
    I(:,4:6) = 0;
    job{1}.spm.stats.con.consess{2}.fcon.weights = [I repelem(0,8,3)];
    job{1}.spm.stats.con.consess{2}.fcon.sessrep = 'none';

    %job{1}.spm.stats.con.consess{1}.tcon.name = 'Stimulation > Null 1';
    %job{1}.spm.stats.con.consess{1}.tcon.weights = [2 2 2 0 0 0 -3 -3 repelem(0,3)];
    %job{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    
    %job{1}.spm.stats.con.consess{2}.tcon.name = 'Imagery > Null 2';
    %job{1}.spm.stats.con.consess{2}.tcon.weights = [0 0 0 2 2 2 -3 -3 repelem(0,3)];
    %job{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

    %job{1}.spm.stats.con.consess{3}.fcon.name = 'Effects of interest';
    %job{1}.spm.stats.con.consess{3}.fcon.weights = [eye(8) repelem(0,8,3)];
    %job{1}.spm.stats.con.consess{3}.fcon.sessrep = 'none';


    job{1}.spm.stats.con.delete = 1;
    
    % run batch
    spm_jobman('run',job);
    
    %% extract ROI
    folder_path_preROI = fullfile(folder_path_data, 'rois');
    file_path_preROI = cellstr(spm_select('FPList', folder_path_preROI, '^.*\.nii$'));
    
    roi_names = {'rBA2', 'lIPL', 'SMA', 'rIFG', 'lIFG', 'rBA1', 'rBA2', 'rBA3b', 'lSII', 'rSII'};
    
    for i=1:numel(file_path_preROI)
        
        clear job;
        
        job{1}.spm.util.voi.spmmat = {file_path_SPMmat};
        job{1}.spm.util.voi.adjust = 2;
        job{1}.spm.util.voi.session = 1;
        job{1}.spm.util.voi.name = roi_names{i};
        
        % get voxels
        job{1}.spm.util.voi.roi{1}.spm.spmmat = {file_path_SPMmat};
        %job{1}.spm.util.voi.roi{1}.spm.contrast = [1 2];
        job{1}.spm.util.voi.roi{1}.spm.contrast = 1;
        job{1}.spm.util.voi.roi{1}.spm.conjunction = 1;
        %job{1}.spm.util.voi.roi{1}.spm.threshdesc = 'FWE';
        %job{1}.spm.util.voi.roi{1}.spm.thresh = 0.05;
        
        job{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
        job{1}.spm.util.voi.roi{1}.spm.thresh = 0.01;

        job{1}.spm.util.voi.roi{1}.spm.extent = 0;
        job{1}.spm.util.voi.roi{1}.spm.mask = struct('contrast', {}, 'thresh', {}, 'mtype', {});
        
        % predefined mask
        job{1}.spm.util.voi.roi{2}.mask.image = {file_path_preROI{i}};
        job{1}.spm.util.voi.roi{2}.mask.threshold = 0.99;
        
        % define sphere
        job{1}.spm.util.voi.roi{3}.sphere.centre = [0 0 0];
        job{1}.spm.util.voi.roi{3}.sphere.radius = 8;
        job{1}.spm.util.voi.roi{3}.sphere.move.global.spm = 1;
        job{1}.spm.util.voi.roi{3}.sphere.move.global.mask = 'i2';
        job{1}.spm.util.voi.expression = 'i1 & i2 & i3';
        
        % run batch
        spm_jobman('run',job);
    end
end % subject loop