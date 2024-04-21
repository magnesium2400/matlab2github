# `matlab2github`: easily convert your docstrings to (GitHub Flavored) Markdown
And easily host them on GitHub pages without downloading any more software!

## Getting started
1. Download or clone [this repo](https://github.com/magnesium2400/matlab2github/tree/main) and add it to your path. 
2. Add docstrings to your functions (see [here](https://mathworks.com/help/matlab/matlab_prog/marking-up-matlab-comments-for-publishing.html) for information on formatting docstrings, or use the files in this repo as an example). 
3. Navigate to the root directory and run `matlab2github` from the Command Window (or run `matlab2github(TARGET_DIRECTORY)`). 
4. Markdown files will be output in `./docs`. These are ready to be pushed to GitHub, and you can easily [deploy them using GitHub pages](https://magnesium2400.github.io/page_creation.html). 

## Formatting docstrings for GitHub
See [here](https://github.com/magnesium2400/matlab2github/blob/main/docs/m2md.md) for an example of how output is rendered on GitHub.

This function converts the "docstring" (the first comment in the `.m` file) into (GitHub® Flavored) Markdown. This function combines the functionality of MATLAB®'s inbuilt PUBLISH and EXPORT functions, as well as some syntax derived from markdown and GitHub Flavored Markdown. For example, use asterisks for **bold** (`*bold*`) text (MATLAB); underscores for *italic* (`_italic_`) text (MATLAB); 1 or 2 dollar signs for inline or block equations like $e^{i\pi } +1=0$ (\$ e^{i \\pi} + 1 = 0 \$); two spaces at the start of a line for sample code (MATLAB); three spaces at the start of a line for executable code (MATLAB); asterisks and numbers for lists (MATLAB and markdown); backticks for `inline code` (markdown).

## Formatting docstrings for GitHub Pages
Currently, the outputs from `matlab2github` are best suited to simple GitHub Pages [templates](https://pages.github.com/themes/).  For example, the [website associated with this repo](https://magnesium2400.github.io/matlab2github/) was auto-generated from the docstrings in the MATLAB functions and the [just-the-docs](https://github.com/just-the-docs/just-the-docs) template. [See here](https://magnesium2400.github.io/page_creation.html) for information on setting up a page in this manner. 


