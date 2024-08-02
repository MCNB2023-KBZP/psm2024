%-----------------------------------------------------------------------
% Job saved on 02-Aug-2024 01:41:48 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.fmri_spec.dir = {'C:\Users\Lenovo\Documents\PSM\PPI\data\sub-001\1st_level_good_bad_Imag'};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'scans';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 3;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = {
                                                 'C:\Users\Lenovo\Documents\PSM\PPI\shared_data\sub-001\run-01\ds8wragf4d_sub001_run01.nii,1'
                                                 'C:\Users\Lenovo\Documents\PSM\PPI\shared_data\sub-001\run-02\ds8wragf4d_sub001_run02.nii,1'
                                                 'C:\Users\Lenovo\Documents\PSM\PPI\shared_data\sub-001\run-03\ds8wragf4d_sub001_run03.nii,1'
                                                 'C:\Users\Lenovo\Documents\PSM\PPI\shared_data\sub-001\run-04\ds8wragf4d_sub001_run04.nii,1'
                                                 'C:\Users\Lenovo\Documents\PSM\PPI\shared_data\sub-001\run-05\ds8wragf4d_sub001_run05.nii,1'
                                                 'C:\Users\Lenovo\Documents\PSM\PPI\shared_data\sub-001\run-06\ds8wragf4d_sub001_run06.nii,1'
                                                 };
matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {'C:\Users\Lenovo\Documents\PSM\PPI\data\sub-001\1st_level_good_bad_Imag\PPI_StimvsImag_1_rBA2.mat'};
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'PPI-interaction';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;
