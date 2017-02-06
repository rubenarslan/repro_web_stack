## Reproducible web stack

This is a stack of tools that have served me well to generate reproducible websites.
Some defaults were set to make things more seamless and I added some files to show it works. This is a fairly opinionated approach and your mileage may vary.

The website generated from these scripts can be viewed at:  
https://rubenarslan.github.io/repro_web_stack


## Set up
Here's how to set up:

1. Fork this repository (top right).

2. Clone your fork (Click the green Clone or download button) to a local folder.

3. Open the repro_web_stack.Rproj file in RStudio.

4. In RStudio packrat should start installing packages, if not, consider running

	```r
	packrat::restore() # this should run by default if you open the project in an up-to-date RStudio version
	packrat::disable() # because packrat is a bit immature, it's probably easier to turn it on at the end, when you archive your project, but it may also make sense to put up with the immaturities if you're working on a lot of projects in parallel.
	```

5. The best way I've found to manage the resulting HTML-files is to keep them in a sub-directory (called _site by default) and to checkout the `gh-pages` branch for your repository in that directory as a submodule. I hope I set it up correctly, so this works out of the box, when you fork the repository, let me know if not. 

6. I've found SourceTree handle Git with submodules in a quite user-friendly manner, RStudio not quite yet.  
RStudio says you can also use a subdirectory called "docs/" in the master branch, but that doesn't appear to work if you're a regular Github user.

## Configuration

Here's a few files you might want to edit:

1. `.zenodo.json` this file contains the metadata that will be used to describe your releases on Zenodo. Add the project name and the authors in this file.

2. `_site.yml` here you can set up a few global settings for how your site should look like. [More information](http://rmarkdown.rstudio.com/rmarkdown_websites.html).

3. `0_helpers.R` - here I load a few packages that I tend to always use. I think it makes sense to load a basic set of packages in this helper file and include it everywhere. Load order matters hugely in R (especially when you use dplyr, which has lots of name conflicts with other packages) and it can simplify things for you, when you know the load order. I've also set a few defaults here that make sense to me.

4. The name of the `.Rproj` file to something descriptive of your project (and correspondingly, the name on Github).

## Releasing to Zenodo

To release to Zenodo via the API, your repository needs to be public. Then, go to [Zenodo](https://zenodo.org/), connect your Github account, flip the switch next to the project name and make a release on Github. It will automatically be uploaded to Zenodo and you will get a DOI, like this [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.268888.svg)](https://doi.org/10.5281/zenodo.268888). I usually release the gh-pages branch, because that's the readable part.

If you don't want your R-code to be public, but only the HTML files, you can either: download a zip of a private release of your gh-pages branch and upload that to Zenodo by hand or you can make a separate, public repository for your HTML files and check this out in your _site directory.

