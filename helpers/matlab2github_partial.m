function matlab2github_partial(varargin)
%% MATLAB2GITHUB_PARTIAL Helper function to run one nested sub-directory
%% Examples
%   tmp = cd(fileparts(which('matlab2github'))); matlab2github_partial('helpers'); cd(tmp);  
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


ip = inputParser;
addOptional(ip, 'folder', pwd, @(x) isStringScalar(x) || ischar(x));
addParameter(ip, 'outputdir', 'docs', @(x) isStringScalar(x) || ischar(x));
addParameter(ip, 'addFrontmatter', true, @islogical);

ip.parse(varargin{:});


matlab2github(ip.Results.folder, ...
    'outputdir', fullfile(ip.Results.outputdir, ip.Results.folder), ...
    'addFrontmatter', ip.Results.addFrontmatter, ...
    'isNested', true);

end
