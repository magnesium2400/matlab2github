function [out, idx] = readFrontmatter(filepath)
%% READFRONTMATTER Read YAML-style frontmatter from document
%% Examples
%   addpath(genpath(fileparts(which('matlab2github')))); tmp = readFrontmatter(fullfile(fileparts(which('matlab2github')), 'docs', 'm2md.md'));
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%
%% See also
% writeFrontmatter
%
%

out = struct(); idx = [1 1];
if ~isfile(filepath)
    warning('File not found');
    return;
else
    file = readlines(filepath);
end

% find indices of '---' demarcations, exit if there aren't any
% idx = cellfun(@(x) regexp(x, '^\s*---\s*'), file, 'UniformOutput', 0);
% idx(cellfun(@isempty, idx)) = {0};
% idx = find(cell2mat(idx));
idx = find(cellfun(@(x) ~isempty(regexp(x, '^\s*---\s*', 'once')) && regexp(x, '^\s*---\s*'), file));
if ~any(idx); return; end

beg = idx(1); % start of yaml
fin = idx(2); % end of yaml

% check that there is no text before first '---'
idx2 = cellfun(@(x) regexp(x, '[\S]*'), file(1:(beg-1)), 'UniformOutput', 0);
if ~all(cellfun(@isempty, idx2)) % text exists before the first '---' demarcation
    return;
end

% yaml confirmed; now extract data
idx = [beg+1, fin-1];
yaml = cellfun(@strtrim, split(file(idx(1):idx(2)),':'), 'UniformOutput', 0);
if numel(yaml) == 2; yaml = reshape(yaml, 1, 2); end
out = cell2struct(yaml(:,2), yaml(:,1), 1);


end
