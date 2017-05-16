## Reproducible web stack

This is a stack of tools that have served me well to generate reproducible websites.
Some defaults were set to make things more seamless and I added some files to show it works. This is a fairly opinionated approach and your mileage may vary.

The website generated from these scripts can be viewed at:  
https://rubenarslan.github.io/repro_web_stack

## Requirements to get started

- [RStudio](https://www.rstudio.com/products/rstudio/download/) 1.*
- [R](https://cran.rstudio.com/) 3.*
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) (should already be installed on Mac OS Mavericks and above)

## Set up
Here's how to set up:

1. (Optional, if you have a Github account already or are willing to create one). Fork this repository (top right).

2. Open RStudio. In the top right menu "project menu", click new project.

3. In the dialog box that appears, click "Version Control". Copy-paste the URL from your repository (it will be `https://github.com/rubenarslan/repro_web_stack` except with your username, if you forked it). Create the project (you can pick a different name if you'd like).

3. In RStudio packrat should start installing packages, if not, consider running

	```r
	packrat::restore() # this should run by default if you open the project in an up-to-date RStudio version
	packrat::disable() # because packrat is a bit immature, it's probably easier to only turn it on at the end, when you archive your project. It may make sense to put up with the immaturities if you're working on a lot of projects in parallel.
	```

5. Now try whether you can generate the website by clicking "Knit" in the file `1_wrangle_data.Rmd`, then try the other files, then modify them to suit your project.

## Configuration

Here's a few files you might want to edit:

1. `.zenodo.json` this file contains the metadata that will be used to describe your releases on Zenodo. Add the project name and the authors in this file.

2. `_site.yml` here you can set up a few global settings for how your site should look like. [More information](http://rmarkdown.rstudio.com/rmarkdown_websites.html).

3. `0_helpers.R` - here I load a few packages that I tend to always use. I think it makes sense to load a basic set of packages in this helper file and include it everywhere. Load order matters hugely in R (especially when you use dplyr, which has lots of name conflicts with other packages) and it can simplify things for you, when you know the load order. I've also set a few defaults here that make sense to me.

4. The name of the `.Rproj` file to something descriptive of your project (and correspondingly, the name on Github).

## Releasing to Zenodo

To release to Zenodo via the API, your repository needs to be public. Then, go to [Zenodo](https://zenodo.org/), connect your Github account, flip the switch next to the project name and make a release on Github. It will automatically be uploaded to Zenodo and you will get a DOI, like this [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.268888.svg)](https://doi.org/10.5281/zenodo.268888).

If you don't want your R-code to be public, but only the HTML files, you can either: zip the contents of the "docs" folder and upload that to Zenodo by hand or you can make a separate, public repository for your HTML files and check this out in your "docs" folder.

## Notes

### Accessing the generated site on Github pages.

After a bit of trial and error with my students, I think the best option for beginners to release the website you generated, is to serve it from the "docs" folder in your repository. You will have to go to your repository settings on Github and pick "docs" as the Github Pages option.
