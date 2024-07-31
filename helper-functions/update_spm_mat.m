%% path specification
folder_path_root = '/Users/pschm/icloud_link/University/mcnb/2_semester/PSM-II/psm2024';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_data = fullfile(folder_path_root, 'data');

%% initialization
addpath(spm_path)
addpath(folder_path_root)
spm('defaults', 'fmri') 
spm_jobman('initcfg')

%% Update
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
        %disp(r)
        for i = (r*242-241):(r*242) % size(fdir,1)
            new_fname = file_path_run(i+242-(r*242),:);
            SPM.xY.P(i,1:length(new_fname)) = new_fname;
            SPM.xY.VY(i).fname = new_fname_notrail(1,:);
        end
        SPM.xY.P = deblank(SPM.xY.P);
    end
    
    save(file_path_SPMmat, 'SPM')
end