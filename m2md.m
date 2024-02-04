function outputfull = m2md(file, varargin)
%% m2md Convert MATLAB .m docstring/help to Markdown
%% Syntax
%  m2md(file)
%  m2md(file,Name,Value)
%
%  outputFilepath = m2md(file,___)
% 
% 
%% Usage Notes
% This function converts the "docstring" (the first comment in the `.m` file)
% into (GitHub(R) Flavored) Markdown. This function combines the functionality
% of MATLAB(R)'s inbuilt PUBLISH and EXPORT functions, as well as some syntax
% derived from markdown and GitHub Flavored Markdown. For example, use asterisks
% for *bold* (`*bold*`) text (MATLAB); underscores for _italic_ (`_italic_`)
% text (MATLAB); 1 or 2 dollar signs for inline or block equations like $e^{i
% \pi} + 1 = 0$ (``$ e^{i \pi} + 1 = 0 $``); two spaces at the start of a line for
% sample code (MATLAB); three spaces at the start of a line for executable code
% (MATLAB); asterisks and numbers for lists (MATLAB and markdown); backticks for
% `inline code` (markdown).
% 
% See here for more information: 
% 
% * <https://mathworks.com/help/matlab/matlab_prog/marking-up-matlab-comments-for-publishing.html>
% * <https://mathworks.com/help/matlab/matlab_prog/publishing-matlab-code.html>
% * <https://au.mathworks.com/help/matlab/matlab_prog/format-live-scripts.html>
% 
% 
%% Description
% `m2md(file)` generates a markdown file from the "docstring" (first contiguous
% comment block) of the specified MATLAB file. `m2md` saves the markdown file
% with the same name in the same directory. This is done by extracting the first
% comment in the MATLAB code file, converting it to a live script, and then
% using the inbuilt function EXPORT to convert it to markdown.
%  
% `m2md(file,Name,Value)` specifies options for customizing the converted file
% by using one or more name-value arguments in addition to the input argument
% combinations in previous syntaxes. For example, you can change the output
% directory or the name of the output file.
%
% `outputFilepath = m2md(file,___)` generates a markdown file of the specified
% MATLAB file and returns the path of the resulting output file. You can use
% this syntax with any of the input argument combinations in the previous
% syntaxes.
% 
% 
%% Examples
%   m2md('m2md.m')
%   m2md('m2md.m', 'outputdir', 'docs')
% 
% 
%% Input Arguments
% `file - name of file to be converted (string scalar | character vector)`
% 
% 
%% %% Name-Value Arguments
% `outputdir - Name of directory of converted file (string scalar | character
% vector)`
% 
% `outputfile - Name of converted file (string scalar | character vector)`
% 
% 
% `changeTitle - Whether to remove color information from document title (true
% (default) | false)`
% 
% 
% `changeHeading - Whether to format headings with # instead of %% (true
% (default) | false)`
% 
% 
% `changeCode - Whether to replace HTML <samp> tags from code (true (default) |
% false)`
% 
% 
% `changeMonospace - Whether to replace HTML <pre> tags from code (true
% (default) | false)`
% 
% 
%% Output Arguments
% `outputFilepath - name of converted file (string scalar | character vector)`
% 
% 
%% Authors 
% Mehul Gajwani, Monash University, 2024
% 
% 
%% See also 
% EXPORT, PUBLISH, DOC, HELP, LOOKFOR, MAKECONTENTSFILE
% 
% 


%% Prelims
ip = inputParser;
ip.addRequired('file', @(x) isStringScalar(x) || ischar(x));
ip.addParameter('outputdir', '', @(x) isStringScalar(x) || ischar(x));
ip.addParameter('outputfile', '', @(x) isStringScalar(x) || ischar(x));

ip.addParameter('changeCode', true, @islogical);
ip.addParameter('changeMonospace', true, @islogical);
ip.addParameter('changeTitle', true, @islogical);
ip.addParameter('changeHeading', true, @islogical);
ip.addParameter('deleteMlx', true, @islogical);

ip.parse(file, varargin{:});
[~,name,ext]    = fileparts(ip.Results.file);
outputdir       = ip.Results.outputdir;
outputfile      = ip.Results.outputfile;

assert(exist(file, 'file'), "File does not exist");
assert(strcmp(ext, '.m'), "Input file must be .m file");


%% Input and output files
d = dir(file);
filepath = d.folder;
tmpName = [tempname(filepath), '.mlx'];

if isempty(outputdir); outputdir = filepath; end
if isempty(outputfile); outputfile = [name, '.md']; end
if ~exist(outputdir, 'dir'); mkdir(outputdir); end
outputfull = fullfile(outputdir, outputfile);


%% Parse text from first comment
filetext = split(fileread(file), newline);

commented = isLineCommented(filetext);
commentStart = find(commented, 1);
commentEnd = find(~commented(commentStart:end),1)+commentStart-2;

filetext = join(filetext(commentStart:commentEnd), newline);


%% Convert to mlx, open, export, close, and delete
matlab.internal.liveeditor.openAsLiveCode(filetext{1});
activeDoc = matlab.desktop.editor.getActive();
cleanupObj(1) = onCleanup(@() activeDoc.close()); % close .mlx window when completed or errrored 

activeDoc.saveAs(tmpName);
if ip.Results.deleteMlx; cleanupObj(2) = onCleanup(@() delete(tmpName)); end

export(activeDoc.Filename, outputfull, 'HideCode', true, 'Run', false); % activeDoc.close(); % delete(tmpName);


%% Post-translational modifications
% TODO : make sure the html tags are in plaintext environment
out = readlines(outputfull);    
rep = @(d,x,y) cellfun(@(a) strrep(a, x, y), d, 'UniformOutput', false);
if ip.Results.changeCode
    out = rep(out,'<samp>', '`');
    out = rep(out,'</samp>', '`');
end
if ip.Results.changeMonospace
    out = rep(out,'<pre>', '```matlab');
    out = rep(out,'</pre>', '```');
end
if ip.Results.changeTitle
    out = rep(out,'<span style="color:rgb(213,80,0)">', '');
    out = rep(out,'</span>', '');
end
if ip.Results.changeHeading
    out = rep(out,' %%', '#');
end
writelines(out, outputfull);


end % main


%% Helpers
function out = isLineCommented(stringCellArray)
for ii = 1:length(stringCellArray)
    l = strtrim(stringCellArray{ii});
    out(ii) = strlength(l) && strcmp(l(1), '%'); %#ok<AGROW>
end
end

