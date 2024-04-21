---
layout: default
title: matlab2github
checksum: e397e9de65a7d6566b8f42c9bc207a4a
---


 
# MATLAB2GITHUB Generates Markdown files for specified directory in docs folder
 
# Syntax
```matlab
matlab2github
matlab2github(folder)
matlab2github(___,Name,Value)
```
 
# Description

`matlab2github` finds the `.m` files in the current directory, converts each docstring (a.k.a h1 comment) to (GitHub®-Flavored) Markdown, and saves the outputs in a sub-directory named `docs`.


`matlab2github(folder)` instead parses the files in a specified directory.


`matlab2github(_,Name,Value)` specifies options for customizing the converted files by using one or more name-value arguments in addition to the input argument combinations in previous syntaxes. For example, you can change the output directory or the frontmatter of the output file.

 
# Examples
```matlab
matlab2github
matlab2github(pwd)
matlab2github('this_folder')
matlab2github(pwd, 'outputdir', 'help')
```
 
# Input Arguments

`folder - target directory (character vector | string scalar)`

 
## Name-value Arguments

`outputdir - output directory ('./docs' (default) | character vector | string scalar)`


`addFrontmatter - whether to include YAML frontmatter (true (default) | false)` If set to true, the following fields will be included in the YAML frontmatter: `layout` will be set to `default`, `title` will be set to the `.m` filename, and `checksum` will be set to the MD5sum of the docstring text (to avoid unnecessary regneration of unmodified files on subsequent runs).


`isNested - whether to treat the input folder as if it nested (false (default) | true)` If set to true, the output directory will be set to `outputdir/folder`.

 
# Usage Notes
-  Only one level of nesting is currently supported 
 
# TODO
-  check recursion/multiple depths through folder structure 
-  add functionality for contents incl MAKECONTENTSFILE 
-  inform (rather than error) if empty 
 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See also

EXPORT, PUBLISH, DOC, HELP, LOOKFOR, MAKECONTENTSFILE, mlx2md, m2md

