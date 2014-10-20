function [test_orient1, test_set1, sample_asbestos, sample_gyps] = AsbGypsTestSetCreate(valid_asbestos, valid_gypsum, k, percentage)
% Creates a test set. Randomly samples each data set, then creates a test
% set with the required percentage os asbestos fibres in it

% testorient1 = the array of orientation change values for the test set
% testset1 = the structure for the test set
% sampleAsbestos = the structure for the asbestos sample
% sampleGyps = the structure for the gypsum sample

%   percentage = percentage of test set made up of asbestos fibres
%   k = sample size
%   testorient1 = array of orientation change values 

sample_asbestos = SampleAlertData(valid_asbestos, k);
sample_gyps = SampleAlertData(valid_gypsum, k);

% Creates a test set of size k, split in to crocidolite and gypsum as
% according to the percentage specified.
test_set1 = CreateTestSet(percentage,sample_asbestos,sample_gyps);   % returns the data structure for the test set
test_orient1 = ProcessDBData(test_set1);                            % returns the orientation change array
end

