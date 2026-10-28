## ----load species-------------------------------------------------------------

library(OpenRange)


pcontorta <- OpenRange_load_species(species = "Pinus contorta")

if(!is.null(pcontorta)){

  plot(pcontorta[2])

}


## ----availability, include = FALSE--------------------------------------------

# Skip the remaining chunks if the database could not be reached (or if the
# packages used below are not installed) so that the vignette can still be built
# when the internet resource is unavailable.

openrange_available <- !is.null(pcontorta) &&
  requireNamespace("tidyverse", quietly = TRUE)

knitr::opts_chunk$set(eval = openrange_available)


## ----availability note, eval = TRUE, echo = FALSE, results = "asis"-----------

if(!openrange_available){

  cat("**Note:** the OpenRange database was not available when this vignette",
      "was built, so the code below is shown but was not run.\n")

}


## ----get metadata-------------------------------------------------------------

library(tidyverse)

# Grab the stats
  model_stats <- OpenRange_get_stats()

if(!is.null(model_stats)){

# Reformat them into a single table

  model_stats_wide <- bind_rows(model_stats$rangebagging %>%
                     mutate(algorithm = "rangebagging"),
                   model_stats$ppm %>%
                     mutate(algorithm = "ppm"),
                   model_stats$points %>%
                     mutate(algorithm = "points"))


# Get relevant model stats

  model_stats_wide %>%
    filter(model_id == pcontorta$model_id)->test

  print(test %>%
    select(cv_mean_train_npresence,cv_mean_test_n_presence,cv_mean_test_auc,cv_mean_train_auc))

}


