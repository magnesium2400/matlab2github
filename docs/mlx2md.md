---
layout: default
title: mlx2md
checksum: 70ed28bedfd518f486579bce5455189f
---


 
# m2md Convert MATLAB .mlx to Markdown
 
# Syntax
```matlab
mlx2md(file)
f = mlx2md(file)
```
 
# Description

`mlx2md(file)` uses the MATLAB® inbuilt function EXPORT to convert all the text (but not the code) in a `.mlx` file into a Markdown file. The output file will be in the same location but with a file extension `.md`.


`f = mlx2md(f)` returns the path to the output file.

 
# Examples
```matlab
addpath(genpath(fileparts(which('matlab2github')))); mlx2md(fullfile(fileparts(which('matlab2github')), 'data', 'dummy.mlx'));
```
 
# Input Arguments

`file - input file path (character vector | string scalar)`

 
# Output Arguments

`f - output file path (character vector | string scalar)`

 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See also
```matlab
m2md, EXPORT
```
