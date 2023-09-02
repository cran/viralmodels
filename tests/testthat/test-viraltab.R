test_that("viraltab() works", {
  wflow_id <- c("normalized_neural_network", "normalized_neural_network", "simple_neural_network", "simple_neural_network", "simple_MARS", "simple_MARS", "normalized_MARS", "normalized_MARS")
  .config <- c("Preprocessor1_Model1", "Preprocessor1_Model1", "Preprocessor1_Model1", "Preprocessor1_Model1", "Preprocessor1_Model1", "Preprocessor1_Model1", "Preprocessor1_Model1", "Preprocessor1_Model1")
  .metric <- c("rmse", "rsq", "rmse", "rsq")
  mean <- c(226.00, 0.37, 237.28, 0.28, 450.12, 0.45, 450.12, 0.45)
  std_err <- c(66.87, 0.24, 65.47, 0.28, 256.42, 0.01, 256.42, 0.01)
  n <- c(2, 2, 2, 2, 2, 2, 2, 2)
  preprocessor <- c("recipe", "recipe", "workflow_variables", "workflow_variables", "workflow_variables", "workflow_variables", "recipe", "recipe")
  model <- c("mlp", "mlp", "mlp", "mlp", "mars", "mars", "mars", "mars")
  rank <- c(1, 1, 2, 2, 3, 3, 4, 4)
  y <- data.frame(wflow_id, .config, .metric, mean, std_err, n, preprocessor, model, rank)
  cd_2019 <- c(824, 169, 342, 423, 441, 507, 559,
               173, 764, 780, 244, 527, 417, 800,
               602, 494, 345, 780, 780, 527, 556,
               559, 238, 288, 244, 353, 169, 556,
               824, 169, 342, 423, 441, 507, 559)
  vl_2019 <- c(40, 11388, 38961, 40, 75, 4095, 103,
               11388, 46, 103, 11388, 40, 0, 11388,
               0,   4095,   40,  93,  49,  49,  49,
               4095,  6837, 38961, 38961, 0, 0, 93,
               40, 11388, 38961, 40, 75, 4095, 103)
  cd_2021 <- c(992, 275, 331, 454, 479, 553,  496,
               230, 605, 432, 170, 670, 238,  238,
               634, 422, 429, 513, 327, 465,  479,
               661, 382, 364, 109, 398, 209, 1960,
               992, 275, 331, 454, 479, 553,  496)
  vl_2021 <- c(80, 1690,  5113,  71,  289,  3063,  0,
               262,  0,  15089,  13016, 1513, 60, 60,
               49248, 159308, 56, 0, 516675, 49, 237,
               84,  292,  414, 26176,  62,  126,  93,
               80, 1690, 5113,    71, 289, 3063,   0)
  cd_2022 <- c(700, 127, 127, 547, 547, 547, 777,
               149, 628, 614, 253, 918, 326, 326,
               574, 361, 253, 726, 659, 596, 427,
               447, 326, 253, 248, 326, 260, 918,
               700, 127, 127, 547, 547, 547, 777)
  vl_2022 <- c(0,   0,   53250,   0,   40,   1901, 0,
               955,    0,    0,    0,   0,   40,   0,
               49248, 159308, 56, 0, 516675, 49, 237,
               0,    23601,   0,   40,   0,   0,   0,
               0,    0,     0,     0,    0,    0,  0)
  x <- cbind(cd_2019, vl_2019, cd_2021, vl_2021, cd_2022, vl_2022) |> as.data.frame()
  semilla <- 123
  target <- "cd_2022"
  pliegues <- 2
  repeticiones <- 1
  rejilla <- 1
  expect_equal(viraltab(x, semilla, target, pliegues, repeticiones, rejilla), y)
})
