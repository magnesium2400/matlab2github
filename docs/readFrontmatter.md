---
layout: default
title: readFrontmatter
checksum: b8cc70de7b8ba9fccdc2e8113f00331e
---


 
# READFRONTMATTER Read YAML-style frontmatter from file
 
# Syntax
```matlab
fm = readFrontmatter(filepath)
[fm,idx] = readFrontmatter(filepath)
```
 
# Description

`fm = readFrontmatter(filepath)` reads YAML-style frontmatter from a text file and returns it as a struct with the same key-value pairs.


`[fm,idx] = readFrontmatter(filepath)` also returns the positions of the start and end of the YAML frontmatter.

 
# Examples
```matlab
addpath(genpath(fileparts(which('matlab2github')))); fm = readFrontmatter(fullfile(fileparts(which('matlab2github')), 'docs', 'm2md.md'))
```
 
# Input Arguments

`filepath - file path (character vector | string scalar)`

 
# Output Arguments

`fm - frontmatter (struct)`


`idx - line numbers of start and end of frontmatter (2-element numeric matrix)`

 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See also

writeFrontmatter

