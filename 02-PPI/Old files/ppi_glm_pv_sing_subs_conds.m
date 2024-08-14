 
s= 2;

folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp';
folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));
folder_path_roi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

cd(folder_path_roi);

load 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\sub-002\1st_level_good_bad_Imag\PPI_Stim_rBA2_S2';
    Xglm = PPI.ppi;

    load 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\sub-002\1st_level_good_bad_Imag\VOI_rBA3b_1',
    Yglm = Y;

    cd(folder_path_roi);

    [betas, ~, stats] = glmfit(Xglm, Yglm);

    save('PPI_Stim_rBA2_rBA3b_glm.mat', 'betas', 'stats');
clear



%%

 
s= 1;

folder_path_data = 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp';
folder_path_sub = fullfile(folder_path_data, sprintf('sub-%03d',s));
folder_path_roi = fullfile(folder_path_sub, '1st_level_good_bad_Imag');

cd(folder_path_roi);

load 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\sub-001\1st_level_good_bad_Imag\PPI_Stim_rBA2_S1';
    Xglm = PPI.ppi;

    load 'C:\Users\Lenovo\Documents\PSM\PPI\psm2024\data.tmp\sub-001\1st_level_good_bad_Imag\VOI_rBA3b_1',
    Yglm = Y;

    cd(folder_path_roi);

    [betas, ~, stats] = glmfit(Xglm, Yglm);

    save('PPI_Stim_rBA2_rBA3b_glm.mat', 'betas', 'stats');
clear





