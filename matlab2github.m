function matlab2github(varargin)
%% MATLAB2GITHUB Generates Markdown files for specified directory in docs folder
%% Syntax
%  matlab2github
%  matlab2github(folder)
%  matlab2github(___,Name,Value)
% 
% 
%% Description
% `matlab2github` finds the `.m` files in the current directory, converts each
% docstring (a.k.a h1 comment) to (GitHub(R)-Flavored) Markdown, and saves the
% outputs in a sub-directory named `docs`.
% 
% `matlab2github(folder)` instead parses the files in a specified directory.
% 
% `matlab2github(___,Name,Value)` specifies options for customizing the
% converted files by using one or more name-value arguments in addition to the
% input argument combinations in previous syntaxes. For example, you can change
% the output directory or the frontmatter of the output file.
% 
% 
%% Examples
%   matlab2github
%   matlab2github(pwd)
%   matlab2github('this_folder')
%   matlab2github(pwd, 'outputdir', 'help')
%
%
%% Input Arguments
% `folder - target directory (character vector | string scalar)`
% 
% 
%% %% Name-value Arguments
% `outputdir - output directory ('./docs' (default) | character vector | string
% scalar)`
% 
% `addFrontmatter - whether to include YAML frontmatter (true (default) |
% false)` If set to true, the following fields will be included in the YAML
% frontmatter: `layout` will be set to `default`, `title` will be set to the
% `.m` filename, and `checksum` will be set to the MD5sum of the docstring text
% (to avoid unnecessary regneration of unmodified files on subsequent runs). 
% 
% `isNested - whether to treat the input folder as if it nested (false (default)
% | true)` If set to true, the output directory will be set to
% `outputdir/folder`. 
% 
% 
%% Usage Notes
% * Only one level of nesting is currently supported
%
%
%% TODO
% * check recursion/multiple depths through folder structure
% * add functionality for contents incl MAKECONTENTSFILE
% * inform (rather than error) if empty
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
addParameter(ip, 'isNested', false, @islogical);
% addParameter(ip, 'useSections', true, @islogical);

ip.parse(varargin{:});
f = fullfile(ip.Results.folder);
outputdir = ip.Results.outputdir;
if ~isfolder(outputdir); mkdir(outputdir); end


%% Iterate over folder, create md files in ./docs
% all m files in f recursively, and remove private and tests
ms = dir(fullfile(f, '**\*.m'));
ms = ms(cellfun( @(x) isempty(x), regexp({ms.folder}.', ['private(\', filesep, '|$)'],'dotexceptnewline') ));
ms = ms(cellfun( @(x) isempty(x), regexpi({ms.name}.', '((^test)|(test.m$))') ));
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
        [mdFile, docstring, matched] = ...
            m2md( fullfile(ms(ii).folder, ms(ii).name) , ...
            'outputdir', of, 'addFrontmatter', false);
        if matched; doneString = ' matched\n'; else; doneString = ' done\n'; end

        yaml = struct('layout', 'default', 'title', n, ...
            'checksum', mlreportgen.utils.hash(docstring));
        if isempty(s) && ~ip.Results.isNested
            writeFrontmatter(mdFile, yaml);
            fprintf(doneString);
            continue;
        elseif isempty(s) && ip.Results.isNested
            [~,s] = fileparts(p);
        end

        yaml.parent = s;
        writeFrontmatter(mdFile, yaml);

        % Create parent file in each directory if needed
        indexFile = fullfile(of, strcat(s,'.md'));
        if ~isfile(indexFile)
            writeFrontmatter(indexFile, struct('layout', 'default', 'title', s, 'has_children', 'true'));
        else
            writeFrontmatter(indexFile, struct('has_children', 'true'));
        end

        fprintf(doneString);

    catch ME
        fprintf(' error:\n');
        disp(ME)
    end

end


end
