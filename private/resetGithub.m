function resetGithub(name)

d = dir(name);
filesToKeep = {'_config.yml', 'index.md'};

for ii = 1:length(d)
    if ~d(ii).isdir && ~ismember(d(ii).name, filesToKeep)
        % delete(fullfile(d(ii).folder, d(ii).name));
    elseif d(ii).isdir && ~ismember(d(ii).name, {'.', '..'})
        resetGithub(fullfile(d(ii).folder, d(ii).name));
    end
end

end
