function log = getLogTextStruct()

log = struct('prep', struct('desc', 'PREP pipeline (Bigdely-Shamlo N, Mullen T, Kothe C, Su K-M and Robbins KA (2015))\n', ...
                            'detrend', 'Temporary (not affecting final EEG) detrend data at %.2f Hz cutoff (%.2f s window slide) using using %s detrending to improve performance of down-stream processing. In the case of high pass filtering the pop_eegfiltnew FIR filter is used.\n',...
                            'lineNoise', 'Line noise removal, using routines from the cleanline EEGLAB plugin with  a frequency range of %d Hz, where %d Hz (+- %d Hz bandwith) are tried to be removed in maximally %d iterations. (Mullen, T. (2012). NITRC: CleanLine: Tool/Resource Info. Available online at: http://www.nitrc.org/projects/cleanline)\n',...
                            'reference', struct('robDevThres', 'Detecting noisy or outlier channels based on extreme amplitudes of a Z-score cutoff for robust channel deviation of more than %.2f.\n', ...
                                                'corr', 'Detecting noisy or outlier channels based on lack of correlation with any other channel with a window size of %d s to compute correlations and a threshold of %.2f (the lowest maximum correlation with another channel).\n',...
                                                'ransac', 'Detecting noisy or outlier channels based on lack of predictability by other channels using a RANSAC sample size of %d in a fraction of %.2f evaluation channels to predict a channel. Channels are bad if the RANSAC prediction in a fraction of %.2f windows of %.2f s duration falls below the absolute correlation of %.2f.\n',...
                                                'highFreqNoise', 'Detecting noisy or outlier channels based on unusual high frequency noise using a Z-score cutoff for SNR (signal above 50* Hz) of %.2f.\n', ...
                                                'maxIter', 'Robust referencing using maximally %.2f.\n'...
                                                )...
                        ),...
             'clean_rawdata', struct('desc', 'clean_rawdata() 0.34 (by Christian Kothe http://sccn.ucsd.edu/wiki/Plugin_list_process)\n', ...
                                     'noASRFilter', 'Temporary (not affecting final data) detrend data with a high pass filter (forward-backward (non-causal) filter) with a transition band of [%.2f %.2f] (stop-band attenuation of 80*dB)\n', ...
                                     'ASRFilter', 'Detrend data (affecting final data) with a high pass filter (forward-backward (non-causal)  filter) with a transition band of [%.2f %.2f] (stop-band attenuation of 80*dB)\n', ...
                                     'flatLine', 'Detecting (near-) flat-lined channels with a maximally tolerated %.2f duration of 5* s and a maximum tolerated jitter during flatlines of 20* x epsilon (i.e. floating-point relative accuracy).\n', ...
                                     'lineNoise', 'Detecting noisy or outlier channels based on exceeding noise level of more than %.2f standard deviations compared to the total channel population\n', ...
                                     'ransac', 'Detecting noisy or outlier channels based on lack of predictability by other channels using a RANSAC sample size of 50* in a fraction of 0.25* evaluation channels to predict a channel. Channels are bad if the RANSAC prediction in a fraction of 0.4* windows of 5* s duration falls below the absolute correlation of %.2f.\n', ...
                                     'burst','Reconstructing epochs of the EEG that are contaminated abnormally strong power (more than %.2f SD relative to calibration data)using Artifact Subspace Reconstruction (REFERENCE). The subspaces on which those events occur are reconstructed (interpolated) based on the rest of the EEG signal during these time periods.\n',...
                                     'window','Time windows are removed that were not repaired completely if the maximum number of channels is greater than %.2f.\n'...
                        ),...
             'filtering', struct('desc', 'pop_eegfiltnew() of EEGLAB (Widmann A, Schröger E. Filter effects and filter artifacts in the analysis of electrophysiological data. Frontiers in psychology. 2012 Jul;3:233)\n', ...
                                 'high', 'Performed a high pass filter using pop_eegfiltnew() FIR filter  with passband edge(s): %.2f Hz, filter order: %.2f, transition band width:  %.2f Hz.\n', ...
                                 'low', 'Performed a low pass filter using pop_eegfiltnew() FIR filter with passband edge(s): %.2f Hz, filter order: %.2f, transition band width:  %.2f Hz.\n', ...
                                 'notch', 'Performed a bandpass filter using pop_eegfiltnew() FIR filter with passband edge(s): %.2f Hz, filter order: %.2f, transition band width:  %.2f Hz.\n' ...
                        ),...
              'badchans', struct('desc', 'Removing a total of %d noisy or outlier channels\n', ...
                                 'prep', 'Number of channels removed due to PREP: %d\n', ...
                                 'asr', 'Number of channels removed due to clean_rawdata(): %d\n', ...
                                 'flatline', 'Number of channels removed due to being flatlines: %d\n' ...
                        ),...
               'eog', struct('desc', 'Remove the effect of EOG using linear analysis  (Parra, L. C., Spence, C. D., Gerson, A. D., & Sajda, P. (2005). Recipes for the linear analysis of EEG. Neuroimage, 28(2), 326-341.)\n' ...
                        ),...
               'ica', struct('desc', 'Automatic classification and removal of artifactual source components using Multiple Artifact Rejection Algorithm (MARA) (Winkler, I., Haufe, S., & Tangermann, M. (2011). Automatic classification of artifactual ICA-components for artifact removal in EEG signals. Behavioral and Brain Functions, 7(1), 30.)\n', ...
                             'filtering', 'Performed a temporary (not affecting final data) high pass filter using pop_eegfiltnew() FIR filter  with passband edge(s): %.2f Hz, filter order: %.2f, transition band width:  %.2f Hz.\n', ...
                             'reject', 'Run an ICA decomposition of an EEG dataset using the EEGLAB function runica(), removing %d, while retaining %.2f % Variance.', ...
                             'remove', 'Automatic classification of multiple artifact components based on 6 features from the time domain, the frequency domain, and the pattern\n Remove classified components and subtract their activities from the (not temporarily filtered) data\n' ...
                        ),...
               'pca', struct('desc', 'Remove DC offset by subtracting the channel mean\n',...
                             'params', 'The weight on sparse error term in the cost function is 1 / sqrt(numChans) or if not default  %.4f with a tolerance %.4f of for stopping criterion and a maximum number of %d iterations'...
                        ),...
               'dc', struct('desc', 'Remove DC offset by subtracting the channel mean\n' ...
                             ),...
               'highvar', struct('desc', 'Identify remaining noisy or outlier channels based on a higher variance than %.2f\n' ...
                             ),...
               'interpolate', struct('desc', 'Interpolate noisy or outlier channels using eeg_interp() with %s method\n' ...
                             ),...
               'quality', struct('OHA', 'Calculate quality measures with Overall thresholds of %s, ',...
                                 'THV','time thresholds of %s, ', ... 
                                 'CHV', 'channel thresholds of %s\n' ...
                             )...
                    );
                

end