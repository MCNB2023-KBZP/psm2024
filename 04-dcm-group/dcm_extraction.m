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
    
    
    %% change paths in SPM.mat
    load(file_path_SPMmat);
    SPM.swd = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

    for r=1:6
        folder_path_run = fullfile(folder_path_sub, sprintf('run-0%d',r));
        file_path_run = spm_select('ExtFPList', folder_path_run, '^ds8wragf4d.*$');
        fname = spm_str_manip(SPM.xY.P, 't');
        new_fname_notrail = strcat(spm_str_manip(file_path_run, 'r'), '.nii');
        disp(r)
        for i = (r*242-241):(r*242) % size(fdir,1)
            new_fname = file_path_run(i+242-(r*242),:);
            SPM.xY.P(i,1:length(new_fname)) = new_fname;
            SPM.xY.VY(i).fname = new_fname_notrail(1,:);
        end
        SPM.xY.P = deblank(SPM.xY.P);
    end
    
    save(file_path_SPMmat, 'SPM')
    
    %% define contrasts
    clear job;
    
    job{1}.spm.stats.con.spmmat = {file_path_SPMmat};
    
    job{1}.spm.stats.con.consess{1}.tcon.name = 'Perception union';
    job{1}.spm.stats.con.consess{1}.tcon.weights = [1 1 1 repelem(0,8)];
    job{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    
    job{1}.spm.stats.con.consess{2}.fcon.name = 'Effects of interest';
    job{1}.spm.stats.con.consess{2}.fcon.weights = [eye(3) repelem(0,3,8)];
    job{1}.spm.stats.con.consess{2}.fcon.sessrep = 'none';
    
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
        job{1}.spm.util.voi.roi{1}.spm.contrast = 1;
        job{1}.spm.util.voi.roi{1}.spm.conjunction = 1;
        job{1}.spm.util.voi.roi{1}.spm.threshdesc = 'FWE';
        job{1}.spm.util.voi.roi{1}.spm.thresh = 0.05;
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