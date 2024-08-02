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

%% prepare
sub_all = [1 2 3 4 5 6 7 8 9 10];
n_scans = [242 242 242 242 242 242];
cond_dur = [3 3 3 3 3 3 3 3 1 0 3];


for s=sub_all

    folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));
    folder_path_sub_glm = fullfile(folder_path_sub, '1st_level_good_bad_Imag');
    file_path_SPMmat = fullfile(folder_path_sub_glm, 'SPM.mat');
    load(fullfile(folder_path_sub, sprintf('all_onsets_goodImag_sub%03d.mat', s)));
        
    folder_path_sub_glm_new = fullfile(folder_path_sub, '1st_level_new');
    
    if ~exist(folder_path_sub_glm_new,'dir')
        mkdir(folder_path_sub_glm_new);
    end


    adjust = (cumsum(n_scans) - 242)*2;
    onsets_adj = onsets;
    onsets_final = [];
    for i=1:11
        concatenated = [];
        for j=1:6
            onsets_adj{j,i} = onsets_adj{j,i} + adjust(j);
            concatenated = [concatenated onsets_adj{j,i}];
        end
        onsets_final{i} = concatenated;
    end

    
    
    %% specify GLM
    clear job
    
    file_path_scans = cellstr(spm_select('ExtFPListRec', folder_path_sub, '^ds8wragf4d.*\.nii'));

    job{1}.spm.stats.fmri_spec.dir = {folder_path_sub_glm_new};
    job{1}.spm.stats.fmri_spec.timing.units = 'secs';
    job{1}.spm.stats.fmri_spec.timing.RT = 2;
    job{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
    job{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
    job{1}.spm.stats.fmri_spec.sess.scans = file_path_scans;

    for c=1:11
        job{1}.spm.stats.fmri_spec.sess.cond(c).name = condnames{c};
        job{1}.spm.stats.fmri_spec.sess.cond(c).onset = onsets_final{c};
        job{1}.spm.stats.fmri_spec.sess.cond(c).duration = cond_dur(c);
        job{1}.spm.stats.fmri_spec.sess.cond(c).tmod = 0;
        job{1}.spm.stats.fmri_spec.sess.cond(c).pmod = struct('name', {}, 'param', {}, 'poly', {});
        job{1}.spm.stats.fmri_spec.sess.cond(c).orth = 1;
    end

    job{1}.spm.stats.fmri_spec.sess.multi = {''};
    job{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
    job{1}.spm.stats.fmri_spec.sess.multi_reg = {''};
    job{1}.spm.stats.fmri_spec.sess.hpf = 128;
    job{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    job{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    job{1}.spm.stats.fmri_spec.volt = 1;
    job{1}.spm.stats.fmri_spec.global = 'None';
    job{1}.spm.stats.fmri_spec.mthresh = 0.8;
    job{1}.spm.stats.fmri_spec.mask = {''};
    job{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

    spm_jobman('run', job);

    %% concat
    spm_fmri_concatenate(fullfile(folder_path_sub_glm_new, 'SPM.mat'), n_scans)

    %% estimate GLM
    clear job 

    job{1}.spm.stats.fmri_est.spmmat = {fullfile(folder_path_sub_glm_new, 'SPM.mat')};
    job{1}.spm.stats.fmri_est.write_residuals = 0;
    job{1}.spm.stats.fmri_est.method.Classical = 1;

    spm_jobman('run', job);

end