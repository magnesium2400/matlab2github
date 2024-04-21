function fm = writeFrontmatter(filepath, dataStruct)
%% WRITEFRONTMATTER Add YAML-style frontmatter to file
%% Syntax
%  writeFrontmatter(filepath, dataStruct)
%  fm = writeFrontmatter(filepath, dataStruct)
% 
% 
%% Description
% `writeFrontmatter(filepath, dataStruct)` adds the data from the key-value
% pairs in the struct `dataStruct` to the file specified by `filepath` as
% YAML-styele frontmatter. If the target file already has frontmatter, any
% fields contained in both the original and new data will be overwritten.
% 
% `fm = writeFrontmatter(filepath, dataStruct)` also returns the text that was
% written in the N fields of `dataStruct` as an N × 1 string array.
% 
% 
%% Examples
%   writeFrontmatter(tempname(pwd), struct('f1', 'v1', 'f2', 'v2'));
%   f = tempname(pwd); fid = fopen(f, 'w'); fm = writeFrontmatter(f, struct('f1', 'v1', 'f2', 'v2')); fclose(fid);
%   f = tempname(pwd); fid = fopen(f, 'w'); writeFrontmatter(f, struct('f1', 'v1', 'f2', 'v2')); writeFrontmatter(f, struct('f1', 'v11', 'f3', 'v3')); fclose(fid);
% 
% 
%% Input Arguments
% `filepath - file path (character vector | string scalar)`
% 
% `dataStruct - data to be written (struct)` Each field and the value within
% will be written to the specified file. Any fields in the file that are not
% also in this struct will be retained. And fields in the file that are also in
% this struct will be overwritten. 
% 
% 
%% Output Arguments
% `fm - text written into front matter (string array)`
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 
%% See also
% readFrontmatter
% 
% 

if ~isfile(filepath)
    origFm = struct();
    origIdx = [1 1];
    file = {''};
else 
    [origFm, origIdx] = readFrontmatter(filepath);
    file = readlines(filepath);
end

if isempty(fieldnames(origFm)) % if no frontmatter
    fm = string(cellfun(@(x) strcat(x, ": ", dataStruct.(x)), fieldnames(dataStruct), 'uni', 0));
    file = ["---"; fm; "---"; ""; file];
else % add to pre-existing frontmatter
    newFm = mergeStructures(origFm, dataStruct);
    fm = string(cellfun(@(x) strcat(x, ": ", newFm.(x)), fieldnames(newFm), 'uni', 0));
    file = [file(1:origIdx(1)-1); fm; file((origIdx(2)+1):end)];
end

writelines(file, filepath);

end
