function f = mlx2md(file)
%% m2md Convert MATLAB .mlx to Markdown
%% Syntax
%  mlx2md(file)
%  f = mlx2md(file)
% 
% 
%% Description
% `mlx2md(file)` uses the MATLAB(R) inbuilt function EXPORT to convert all the
% text (but not the code) in a `.mlx` file into a Markdown file. The output file
% will be in the same location but with a file extension `.md`.
% 
% `f = mlx2md(f)` returns the path to the output file. 
% 
% 
%% Examples
%   addpath(genpath(fileparts(which('matlab2github')))); mlx2md(fullfile(fileparts(which('matlab2github')), 'data', 'dummy.mlx')); 
% 
% 
%% Input Arguments
% `file - input file path (character vector | string scalar)`
% 
% 
%% Output Arguments
% `f - output file path (character vector | string scalar)`
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 
%% See also
%  m2md, EXPORT
% 


assert(isfile(file), "File does not exist"); 
[filepath,name,ext] = fileparts(file);
assert(strcmp(ext, '.mlx'), 'Input file must be a .mlx file');

f = fullfile(filepath, [name, '.md']);
export(file, f, 'HideCode', true, 'Run', false);


end

