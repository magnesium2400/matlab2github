function mlx2md(file)
%% m2md Convert MATLAB .mlx to Markdown
%% Examples
%   addpath(genpath(fileparts(which('matlab2github')))); mlx2md(fullfile(fileparts(which('matlab2github')), 'data', 'dummy.mlx')); 
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 
%% See also
% m2md
% 


assert(isfile(file), "File does not exist"); 
[filepath,name,ext]    = fileparts(file);
assert(strcmp(ext, '.mlx'), 'Input file must be a .mlx file');
export(file, fullfile(filepath, [name, '.md']), 'HideCode', true, 'Run', false);


end

