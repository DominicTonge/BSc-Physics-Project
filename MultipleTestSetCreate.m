function [test_sets] = MultipleTestSetCreate(valid1, valid_gypsum, k, percentage, nmax)
% Creates a number, nmax, of random test sets
%   validdata = asbestos
%   validGyps = gypsum
%   k = sample size
%   percentage = percentage asbestos in the samples
%   nmax = number of test samples to be created


for n = 1:nmax
    test_sets(n) = {AsbGypsTestSetCreate(valid1, valid_gypsum, k, percentage)};   
end

end

