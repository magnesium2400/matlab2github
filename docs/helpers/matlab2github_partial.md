---
layout: default
title: matlab2github_partial
checksum: 55cba0eb9fe712969f4ff606c678f56f
parent: helpers
---


 
# MATLAB2GITHUB_PARTIAL Helper function to run one nested sub-directory
 
# Syntax
```matlab
matlab2github_partial(folder)
matlab2github_partial(folder,Name,Value)
```
 
# Description

`matlab2github_partial(folder)` runs `matlab2github` only on the files contained in the directory `folder`. It outputs the markdown files in `./docs/folder`, as well as an index file for that directory.


`matlab2github_partial(folder,Name,Value)` specifies options for customizing the converted files by using one or more name-value arguments in addition to the input argument `folder`.

 
# Examples
```matlab
tmp = cd(fileparts(which('matlab2github'))); matlab2github_partial('helpers'); cd(tmp);
```
 
# Input Arguments

`folder - target directory (character vector | string scalar)`

 
## Name-value Arguments

`outputdir - output directory ('./docs' (default) | character vector | string scalar)`


`addFrontmatter - whether to include YAML frontmatter (true (default) | false)` If set to true, the following fields will be included in the YAML frontmatter: `layout` will be set to `default`, `title` will be set to the `.m` filename, and `checksum` will be set to the MD5sum of the docstring text (to avoid unnecessary regneration of unmodified files on subsequent runs).

 
# Authors

Mehul Gajwani, Monash University, 2024

