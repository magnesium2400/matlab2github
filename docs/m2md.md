---
layout: default
title: m2md
checksum: 588b78e239813562fa48c1a4c1dd5cc3
---


 
# m2md Convert MATLAB .m docstring/help to Markdown
 
# Syntax
```matlab
m2md(file)
m2md(file,Name,Value)
```
```matlab
outputFilepath = m2md(file,___)
```
 
# Usage Notes

This function converts the "docstring" (the first comment in the `.m` file) into (GitHub® Flavored) Markdown. This function combines the functionality of MATLAB®'s inbuilt PUBLISH and EXPORT functions, as well as some syntax derived from markdown and GitHub Flavored Markdown. For example, use asterisks for **bold** (`*bold*`) text (MATLAB); underscores for *italic* (`_italic_`) text (MATLAB); 1 or 2 dollar signs for inline or block equations like $e^{i\pi } +1=0$ (\$ e^{i \\pi} + 1 = 0 \$); two spaces at the start of a line for sample code (MATLAB); three spaces at the start of a line for executable code (MATLAB); asterisks and numbers for lists (MATLAB and markdown); backticks for `inline code` (markdown).


See here for more information:

-  [https://mathworks.com/help/matlab/matlab_prog/marking-up-matlab-comments-for-publishing.html](https://mathworks.com/help/matlab/matlab_prog/marking-up-matlab-comments-for-publishing.html) 
-  [https://mathworks.com/help/matlab/matlab_prog/publishing-matlab-code.html](https://mathworks.com/help/matlab/matlab_prog/publishing-matlab-code.html) 
-  [https://au.mathworks.com/help/matlab/matlab_prog/format-live-scripts.html](https://au.mathworks.com/help/matlab/matlab_prog/format-live-scripts.html) 
 
# Description

`m2md(file)` generates a markdown file from the "docstring" (first contiguous comment block) of the specified MATLAB file. `m2md` saves the markdown file with the same name in the same directory. This is done by extracting the first comment in the MATLAB code file, converting it to a live script, and then using the inbuilt function EXPORT to convert it to markdown.


`m2md(file,Name,Value)` specifies options for customizing the converted file by using one or more name-value arguments in addition to the input argument combinations in previous syntaxes. For example, you can change the output directory or the name of the output file.


`outputFilepath = m2md(file,___)` generates a markdown file of the specified MATLAB file and returns the path of the resulting output file. You can use this syntax with any of the input argument combinations in the previous syntaxes.

 
# Examples
```matlab
m2md('m2md.m')
m2md('m2md.m', 'outputdir', 'docs')
```
 
# Input Arguments

`file - name of file to be converted (string scalar | character vector)`

 
## Name-Value Arguments

`skipMatchingChecksum - Whether to skip re-running code if docstring and output file are unchanged (true (default) | false)` By default, output markdown files contain a hash of the docstring used to generate them. If re-running this command and the target output file contains the same checksum as the docstring of the MATLAB code file being analysed (*not the whole file*), and `skipMatchingChecksum` is set to `true`, a new markdown file will not be generated. This speeds up re-running code on existing codebases.


`addFrontmatter - Whether to add YAML-style frontmatter (true (default) | false)` This adds YAML-style frontmatter that may aid in the use of templates when creating webpages using GitHub pages.


`outputdir - Name of directory of converted file (string scalar | character vector)`


`outputfile - Name of converted file (string scalar | character vector)`


`changeTitle - Whether to remove color information from document title (true (default) | false)`


`changeHeading - Whether to format headings with # instead of %% (true (default) | false)`


`changeCode - Whether to replace HTML samp tags from code (true (default) | false)`


`changeMonospace - Whether to replace HTML pre tags from code (true (default) | false)`

 
# Output Arguments

`outputFilepath - name of converted file (string scalar | character vector)`

 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See also

EXPORT, PUBLISH, DOC, HELP, LOOKFOR, MAKECONTENTSFILE, mlx2md, matlab2github

