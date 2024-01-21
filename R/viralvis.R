#' Competing models plot
#'
#' viralvis plots the rankings of a series of regression models for viral load
#' or cd4 counts
#'
#' @import earth
#' @import nnet
#' @import parsnip
#' @import recipes
#' @import rsample
#' @import tidyselect
#' @import tune
#' @import vdiffr
#' @import workflows
#' @import workflowsets
#' @importFrom stats as.formula
#'
#' @param x A data frame
#' @param semilla A numeric value
#' @param target A character value
#' @param pliegues A numeric value
#' @param repeticiones A numeric value
#' @param rejilla A numeric value
#'
#' @return A plot of ranking models
#' @export
#'
#' @examples
#' cd_2019 <- c(824, 169, 342, 423, 441, 507, 559,
#'              173, 764, 780, 244, 527, 417, 800,
#'              602, 494, 345, 780, 780, 527, 556,
#'              559, 238, 288, 244, 353, 169, 556,
#'              824, 169, 342, 423, 441, 507, 559)
#' vl_2019 <- c(40, 11388, 38961, 40, 75, 4095, 103,
#'              11388, 46, 103, 11388, 40, 0, 11388,
#'              0,   4095,   40,  93,  49,  49,  49,
#'              4095,  6837, 38961, 38961, 0, 0, 93,
#'              40, 11388, 38961, 40, 75, 4095, 103)
#' cd_2021 <- c(992, 275, 331, 454, 479, 553,  496,
#'              230, 605, 432, 170, 670, 238,  238,
#'              634, 422, 429, 513, 327, 465,  479,
#'              661, 382, 364, 109, 398, 209, 1960,
#'              992, 275, 331, 454, 479, 553,  496)
#' vl_2021 <- c(80, 1690,  5113,  71,  289,  3063,  0,
#'              262,  0,  15089,  13016, 1513, 60, 60,
#'              49248, 159308, 56, 0, 516675, 49, 237,
#'              84,  292,  414, 26176,  62,  126,  93,
#'              80, 1690, 5113,    71, 289, 3063,   0)
#' cd_2022 <- c(700, 127, 127, 547, 547, 547, 777,
#'              149, 628, 614, 253, 918, 326, 326,
#'              574, 361, 253, 726, 659, 596, 427,
#'              447, 326, 253, 248, 326, 260, 918,
#'              700, 127, 127, 547, 547, 547, 777)
#' vl_2022 <- c(0,   0,   53250,   0,   40,   1901, 0,
#'              955,    0,    0,    0,   0,   40,   0,
#'              49248, 159308, 56, 0, 516675, 49, 237,
#'              0,    23601,   0,   40,   0,   0,   0,
#'              0,    0,     0,     0,    0,    0,  0)
#' x <- cbind(cd_2019, vl_2019, cd_2021, vl_2021, cd_2022, vl_2022) |> as.data.frame()
#' semilla <- 123
#' target <- "cd_2022"
#' pliegues <- 2
#' repeticiones <- 1
#' rejilla <- 1
#' viralvis(x, semilla, target, pliegues, repeticiones, rejilla)
viralvis <- function(x, semilla, target, pliegues, repeticiones, rejilla) {
  set.seed(semilla)
  workflowsets::workflow_set(
    preproc = list(simple = workflows::workflow_variables(outcomes = tidyselect::all_of(target), predictors = tidyselect::everything()),
                   normalized = recipes::recipe(stats::as.formula(paste(target,"~ .")), data = x) |>
                     recipes::step_normalize(recipes::all_predictors()),
                   full_quad = recipes::recipe(stats::as.formula(paste(target,"~ .")), data = x) |>
                     recipes::step_normalize(recipes::all_predictors()) |>
                     recipes::step_poly(recipes::all_predictors()) |>
                     recipes::step_interact(~ all_predictors():all_predictors())),
    models = list(MARS = parsnip::mars(prod_degree = parsnip::tune(), num_terms = parsnip::tune(), prune_method = parsnip::tune()) |>
                    parsnip::set_engine("earth") |>
                    parsnip::set_mode("regression"),
                  neural_network = parsnip::mlp(hidden_units = parsnip::tune(), penalty = parsnip::tune(), epochs = parsnip::tune()) |>
                    parsnip::set_engine("nnet", MaxNWts = 2600) |>
                    parsnip::set_mode("regression"),
                  KNN = parsnip::nearest_neighbor(neighbors = parsnip::tune(), dist_power = parsnip::tune(), weight_func = parsnip::tune()) |>
                    parsnip::set_engine("kknn") |>
                    parsnip::set_mode("regression"))
  ) |>
    workflowsets::workflow_map(
      seed = semilla,
      resamples = rsample::initial_split(x) |>
        rsample::training() |>
        rsample::vfold_cv(v = pliegues, repeats = repeticiones),
      grid = rejilla,
      control = tune::control_grid(
        save_pred = TRUE,
        parallel_over = "everything",
        save_workflow = TRUE
      )
    ) |>
    tune::autoplot(
      rank_metric = "rmse",  # <- how to order models
      metric = "rmse",       # <- which metric to visualize
      select_best = TRUE     # <- one point per workflow
    )
}
