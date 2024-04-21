---
layout: default
title: writeFrontmatter
checksum: d735bec63ac8dbff9861998288b73c89
---


 
# WRITEFRONTMATTER Add YAML-style frontmatter to file
 
# Syntax
```matlab
writeFrontmatter(filepath, dataStruct)
fm = writeFrontmatter(filepath, dataStruct)
```
 
# Description

`writeFrontmatter(filepath, dataStruct)` adds the data from the key-value pairs in the struct `dataStruct` to the file specified by `filepath` as YAML-styele frontmatter. If the target file already has frontmatter, any fields contained in both the original and new data will be overwritten.


`fm = writeFrontmatter(filepath, dataStruct)` also returns the text that was written in the N fields of `dataStruct` as an N × 1 string array.

 
# Examples
```matlab
writeFrontmatter(tempname(pwd), struct('f1', 'v1', 'f2', 'v2'));
f = tempname(pwd); fid = fopen(f, 'w'); fm = writeFrontmatter(f, struct('f1', 'v1', 'f2', 'v2')); fclose(fid);
f = tempname(pwd); fid = fopen(f, 'w'); writeFrontmatter(f, struct('f1', 'v1', 'f2', 'v2')); writeFrontmatter(f, struct('f1', 'v11', 'f3', 'v3')); fclose(fid);
```
 
# Input Arguments

`filepath - file path (character vector | string scalar)`


`dataStruct - data to be written (struct)` Each field and the value within will be written to the specified file. Any fields in the file that are not also in this struct will be retained. And fields in the file that are also in this struct will be overwritten.

 
# Output Arguments

`fm - text written into front matter (string array)`

 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See also

readFrontmatter

