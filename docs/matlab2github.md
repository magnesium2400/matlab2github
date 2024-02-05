---
layout: default
title: matlab2github
checksum: 4337be34c4cafcce4fb53a71d36f1a4f
---


 
# MATLAB2GITHUB Generates Markdown files for specified directory in docs folder
 
# Examples
```matlab
matlab2github
matlab2github(pwd)
matlab2github('this_folder')
matlab2github(pwd, 'outputdir', 'help')
```
 
# Usage Notes
-  Only one level of nesting is supported 
 
# TODO
-  docs 
-  check recursion/multiple depths through folder structure 
-  add functionality for contents incl MAKECONTENTSFILE 
-  add functionality to only redo conversion for changed files (perhaps by storing .m file checksum in .md file frontmatter) 
 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See also

EXPORT, PUBLISH, DOC, HELP, LOOKFOR, MAKECONTENTSFILE, mlx2md, m2md

