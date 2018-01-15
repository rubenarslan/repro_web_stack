#' # Helper functions used throughout {.tabset .tabset-sticky}
#' documentation on the functions is interspersed through code comments
#'
#' ## set some options
#' dont show messages when loading libraries
# library = function(...) suppressMessages(base::library(...))
#' never set strings as factors automatically (google for reason why)
options(stringsAsFactors = FALSE)
#' show four significant digits tops
options(digits = 4)
#' tend not to show scientific notation, because we're just psychologists
options(scipen = 7)
#' make output a bit wider
options(width = 110)
#' set a seed to make analyses depending on random number generation reproducible
set.seed(1710) # if you use your significant other's birthday make sure you stay together for the sake of reproducibility

#' ## Load packages
#' generate the site
library(rmarkdown)
#' set options for chunks
library(knitr)
#' my formr utility package to generate e.g. the bibliography
library(formr)
#' pretty-printed output
library(pander)
#' tidyverse date times
library(lubridate)
#' tidyverse strings
library(stringr)
#' extractor functions for models
library(broom)
#' grammar of graphics plots
library(ggplot2)
#' tidyverse: transform data wide to long
library(tidyr)
#' tidyverse-style data wrangling. has a lot of naming conflicts, so always load last
library(dplyr)

#' some packages may be needed without being loaded
fool_packrat = function() {
	# needed to install formr package
	library(devtools)
	# needed to actually run rmarkdown in RStudio, but for some reason not in its dependencies
	library(formatR)
}

#' ## Spin R files
#' R scripts can be documented in markdown using Roxygen comments, as demonstrated here
#' This function turns all R files (that don't have an Rmd file of the same name and that don't start with an underscore _) into HTML pages
spin_R_files_to_site_html = function() {
	library(knitr)
	all_Rs = c(list.files(pattern = "^[^_].+\\.R$"), ".Rprofile")
	component_Rmds = list.files(pattern = "^_.+\\.Rmd$")
	temporary_Rmds = c()
	for (i in seq_along(all_Rs)) {
		if(all_Rs[i] == ".Rprofile") {
			Rmd_file = ".Rprofile.Rmd"
		} else {
			Rmd_file = paste0(all_Rs[i], "md")
		}
		if (!file.exists(Rmd_file)) {
			next_document = length(temporary_Rmds) + 1
			temporary_Rmds[next_document] = spin(all_Rs[i], knit = FALSE, envir = new.env(), format = "Rmd")
			prepended_yaml = paste0(c("---
output:
  html_document:
    code_folding: 'show'
---

", readLines(temporary_Rmds[next_document])), collapse = "\n")
			cat(prepended_yaml, file = temporary_Rmds[next_document])
		}
	}
	components_and_scripts = c(temporary_Rmds, component_Rmds)
	for (i in seq_along(components_and_scripts)) {
		opts_chunk$set(eval = FALSE, cache = FALSE)
		# if we call render_site on the .R file directly it adds a header I don't like
		rmarkdown::render_site(components_and_scripts[i], quiet = TRUE)
	}
	opts_chunk$set(eval = TRUE, cache = TRUE)
	unlink(temporary_Rmds)
}

#' ## Output options
#' use pander to pretty-print objects (if possible)
opts_chunk$set(
	render = pander_handler,
	dev = "svglite"
	)

#' don't split tables, scroll horizontally
panderOptions("table.split.table", Inf)

#' ## Knitr components
#'
#' summarise regression using a "knitr component"
regression_summary = function(model, indent = "##") {
	model_name = deparse(substitute(model_name))
	old_opt = options('knitr.duplicate.label')$knitr.duplicate.label
	options(knitr.duplicate.label = 'allow')
	on.exit(options(knitr.duplicate.label = old_opt))
	options = list(
		fig.path = paste0(knitr::opts_chunk$get("fig.path"), model_name, "_"),
		cache.path = paste0(knitr::opts_chunk$get("cache.path"), model_name, "_")
	)
	formr::asis_knit_child("_regression_summary.Rmd", options = options)
}

