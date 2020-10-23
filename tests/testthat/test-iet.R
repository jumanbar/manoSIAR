test_that("Calcula bien el IET", {

  PT <- c(-1, 0, 1, 10, 100, 1000)

  y <- 10 * (6 - (0.42 - 0.36 * log(PT)) / log(2)) - 20

  # expect_identical(iet(PT), y)
  expect_equal(iet(PT), y)
})

