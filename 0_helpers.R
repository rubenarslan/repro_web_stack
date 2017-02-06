#' # Helper functions used throughout {.tab-content}
#' documentation on the functions is interspersed through code comments
#'
#' ## set some options
#' dont show messages when loading libraries
# library = function(...) suppressMessages(base::library(...))
#' never set strings as factors automatically (google for reason why)
options(stringsAsFactors = FALSE)
#' show four significant digits tops
options(digits = 4)
#' tend not to show scientific notation
options(scipen = 7)
#' make output a bit wider
options(width = 110)

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
#' marginal effects plots for regressions
library(effects)
#' grammar of graphics plots
library(ggplot2)
#' tidyverse: transform data wide to long
library(tidyr)
#' svg graphs
library(svglite);
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
	all_Rs = list.files(pattern = "^[^_].+\\.R$")
	component_Rmds = list.files(pattern = "^_.+\\.Rmd$")
	temporary_Rmds = c()
	for (i in seq_along(all_Rs)) {
		Rmd_file = paste0(all_Rs[i], "md")
		if (!file.exists(Rmd_file)) {
			next_document = length(temporary_Rmds) + 1
			temporary_Rmds[next_document] = spin(all_Rs[i], knit = FALSE, envir = new.env(), format = "Rmd")
		}
	}
	components_and_scripts = c(temporary_Rmds, component_Rmds)
	for (i in seq_along(components_and_scripts)) {
		opts_chunk$set(eval = FALSE, cache = FALSE)
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

#' don't split tables, scroll horizontallys
panderOptions("table.split.table", Inf)

#' allow duplicate chunk labels in knitr, useful for knit_child
options(knitr.duplicate.label = 'allow')


regression_summary = function(model, indent = "##") {
	formr::asis_knit_child("_regression_summary.Rmd")
}
