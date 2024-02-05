---
layout: default
title: writeFrontmatter
---


 
# WRITEFRONTMATTER Add YAML-style frontmatter to file
 
# Examples
```matlab
writeFrontmatter(tempname(pwd), struct('f1', 'v1'));
f = tempname(pwd); fid = fopen(f, 'w'); writeFrontmatter(f, struct('f1', 'v1', 'f2', 'v2')); fclose(fid);
f = tempname(pwd); fid = fopen(f, 'w'); writeFrontmatter(f, struct('f1', 'v1', 'f2', 'v2')); writeFrontmatter(f, struct('f1', 'v11', 'f3', 'v3')); fclose(fid);
```
 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See also

readFrontmatter

