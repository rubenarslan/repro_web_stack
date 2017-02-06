## Reproducible web stack

This is a stack of tools that have served me well to generate reproducible websites.
Some defaults were set to make things more seamless and I added some files to show it works. This is a fairly opinionated approach and your mileage may vary.

Here's how to set up everything:

1. Run

```r
packrat::restore()
packrat::disable() # because packrat is a bit immature, it's probably easier to turn it on at the end, when you archive your project, but it may also make sense to put up with the immaturities if you're working on a lot of projects in parallel.
```

2. Check out the `gh-pages` in the `_site` subdirectory.

```bash
git checkout --orphan gh-pages
git reset
touch index.html
git add index.html
git commit -m "start gh-pages"
mkdir _site
cp -r .git _site/.git
git checkout master -f
cd _site
git branch -D master
cd ../
git branch -D gh-pages
```

Here's a few files you might want to edit:

1. `.zenodo.json` this file contains the metadata that will be used to describe your releases on Zenodo. Add the project name and the authors in this file.

2. `_site.yml` here you can set up a few global settings for how your site should look like. [More information](http://rmarkdown.rstudio.com/rmarkdown_websites.html).

3. `0_helpers.R` - here I load a few packages that I tend to always use. I think it makes sense to load a basic set of packages in this helper file and include it everywhere. Load order matters hugely in R (especially when you use dplyr, which has lots of name conflicts with other packages) and it can simplify things for you, when you know the load order. I've also set a few defaults here that make sense to me.
