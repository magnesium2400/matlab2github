function matlab2github(varargin)
%% MATLAB2GITHUB Generates Markdown files for specified directory in docs folder
%% Examples
%   matlab2github
%   matlab2github(pwd)
%   matlab2github('this_folder')
%   matlab2github(pwd, 'outputdir', 'help')
%
%
%% Usage Notes
% * Only one level of nesting is supported
%
%
%% TODO
% * docs
% * check recursion/multiple depths through folder structure
% * add functionality for contents incl MAKECONTENTSFILE
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%
%% See also
% EXPORT, PUBLISH, DOC, HELP, LOOKFOR, MAKECONTENTSFILE, mlx2md, m2md
%
%

%% Prelims
ip = inputParser;
addOptional(ip, 'folder', pwd, @(x) isStringScalar(x) || ischar(x));
addParameter(ip, 'outputdir', 'docs', @(x) isStringScalar(x) || ischar(x));
addParameter(ip, 'addFrontmatter', true, @islogical);
addParameter(ip, 'useSections', true, @islogical);
addParameter(ip, 'isNested', false, @islogical);

ip.parse(varargin{:});
f = fullfile(ip.Results.folder);
outputdir = ip.Results.outputdir;
if ~isfolder(outputdir); mkdir(outputdir); end


%% Iterate over folder, create md files in ./docs
% all m files in f recursively, and remove private
ms = dir(fullfile(f, '**\*.m'));
ms = ms(cellfun(@(x) isempty(x), (regexp({ms.folder}.', ['private(\', filesep, '|$)'],'dotexceptnewline'))));
d = dir(f);
p = d(1).folder;
l = strlength(p);

for ii = 1:length(ms)

    s = ms(ii).folder;
    s = s( (l+2):end );
    of = fullfile(outputdir, s); % outputfile
    n = ms(ii).name;
    n = n(1:(end-2));

    fprintf("%i/%i: %s", ii, length(ms), n);

    try % continue to all files even if some errors occur
        [mdFile, docstring] = m2md( fullfile(ms(ii).folder, ms(ii).name) , ...
            'outputdir', of, 'addFrontmatter', false);

        yaml = struct('layout', 'default', 'title', n, ...
            'checksum', mlreportgen.utils.hash(docstring));
        if isempty(s) && ~ip.Results.isNested
            writeFrontmatter(mdFile, yaml); 
            fprintf(' done\n'); 
            continue; 
        elseif isempty(s) && ip.Results.isNested
            [~,s] = fileparts(p);
        end

        yaml.parent = s;
        writeFrontmatter(mdFile, yaml);

        % Create parent file in each directory if needed
        indexFile = fullfile(of, strcat(s,'.md'));
        if ~isfile(indexFile)
            f = fopen(mdFile, 'r');
            fclose(f);
            writeFrontmatter(indexFile, struct('layout', 'default', 'title', s, 'has_children', 'true'));
        else
            writeFrontmatter(indexFile, struct('has_children', 'true'));
        end

        fprintf(' done\n');

    catch ME
        fprintf(" error:\n");
        disp(ME)
    end

end



end
