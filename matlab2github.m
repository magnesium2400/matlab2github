function [f, ms, d] = matlab2github(varargin)
%% MATLAB2GITHUB Generates Markdown files for specified directory in docs folder
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 
%% TODO 
% * docs
% * recursion/multiple depths through folder structure
%
%
%% See also
% m2md
%
%

%% Prelims
ip = inputParser;
addOptional(ip, 'folder', pwd, @(x) isStringScalar(x) || ischar(x));
addParameter(ip, 'outputdir', 'docs', @(x) isStringScalar(x) || ischar(x));
addParameter(ip, 'addFrontmatter', true, @islogical);
addParameter(ip, 'useSections', true, @islogical);

ip.parse(varargin{:});
f = fullfile(ip.Results.folder);
outputdir = ip.Results.outputdir;

%% Iterate over folder, create md files in ./docs

ms = dir(fullfile(f, '**\*.m')); %% all m files in f, recursively
d = dir(f);
p = d(1).folder;
l = strlength(p);

for ii = 1:length(ms)

    s = ms(ii).folder;
    s = s((l+2):end);
    of = fullfile(outputdir, s);
    n = ms(ii).name;
    n = n(1:(end-2));

    try
        mdFile = m2md( fullfile(ms(ii).folder, ms(ii).name) , 'outputdir', outputdir);

        yaml = struct('layout', 'default', 'title', n);
        if isempty(s); writeFrontmatter(mdFile, yaml); continue; end
        
        yaml.parent = s;
        writeFrontmatter(mdFile, yaml);
        
        % Create parent file in each directory if needed
        indexFile = fullfile(of, strcat(s,'.md'));
        if ~exist(indexFile, 'file')
            f = fopen(fullfile(of, strcat(s,'.md')), 'wt');
            fclose(f);
            writeFrontmatter(indexFile, struct('layout', 'default', 'title', s, 'has_children', 'true'));
        else
            writeFrontmatter(indexFile, struct('has_children', 'true'));
        end

        fprintf("%i/%i\n", ii, length(ms));


    catch ME
        disp("error: " + n);
        disp(ME)
    end

end


%




end
