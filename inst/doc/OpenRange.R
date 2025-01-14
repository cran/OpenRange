## ----load species-------------------------------------------------------------

library(OpenRange)


pcontorta <- OpenRange_load_species(species = "Pinus contorta")

plot(pcontorta[2])


## ----get metadata-------------------------------------------------------------

library(tidyverse)

# Grab the stats
  model_stats <- OpenRange_get_stats()

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

  test %>%
    select(cv_mean_train_npresence,cv_mean_test_n_presence,cv_mean_test_auc,cv_mean_train_auc)



