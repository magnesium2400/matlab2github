function fm = writeFrontmatter(filepath, dataStruct)
%% WRITEFRONTMATTER Add YAML-style frontmatter to file
%% Examples
%   writeFrontmatter(tempname(pwd), struct('f1', 'v1'));
%   f = tempname(pwd); fid = fopen(f, 'w'); writeFrontmatter(f, struct('f1', 'v1', 'f2', 'v2')); fclose(fid);
%   f = tempname(pwd); fid = fopen(f, 'w'); writeFrontmatter(f, struct('f1', 'v1', 'f2', 'v2')); writeFrontmatter(f, struct('f1', 'v11', 'f3', 'v3')); fclose(fid);
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
