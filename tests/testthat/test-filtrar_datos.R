test_that("Matriz y programa no corresponden", {
  testthat::expect_warning(x <- filtrar_datos(datos_sia, 5, 11),
                           paste("No hay datos de esa matriz ambiental",
                                 "\\(id_matriz \\= 11\\) para el programa de",
                                 "monitoreo solicitado"))

  testthat::expect_s3_class(x, "data.frame")
  testthat::expect_identical(nrow(x), 0L)
})
