idpar <- c(2032L, 2018L, 2009L, 2035L, 2017L, 2111L, 2000L, 2090L, 2005L, 
           2099L, 2008L, 2232L, 2020L, 2098L, 2101L, 2102L, 302L, 303L, 
           301L, 300L, 2097L, 2021L, 2026L, 2145L, 2218L, 2001L, 2028L, 
           2226L, 2082L, 2074L)

x <- suppressWarnings({
  tmp <- datos_sia %>%
    dplyr::filter(id_parametro %in% sample(idpar, 10)) %>% 
    dplyr::group_by(id_programa) %>%
    dplyr::sample_n(10) %>%
    dplyr::ungroup() %>% 
    dplyr::filter(
      id_tipo_dato == 1L,
      siabox::clasif_tipo_dato(limite_deteccion)[[2]] == 1L,
      siabox::clasif_tipo_dato(limite_cuantificacion)[[2]] == 1L
    )
  dplyr::sample_n(tmp, min(10, nrow(tmp)))
})
rm(tmp)

# %>%
#   dplyr::filter(id_programa == 4L)
# test_that("Error si hay más de un id_matriz", {
#   testthat::expect_error(ancho(x),  
#                          "^Los datos tienen más de un valor de id_matriz")
# })

n.par <- length(unique(x$id_parametro))

# x <- x %>%
#   dplyr::mutate(param = nombre_clave)
test_that("Columnas de sobra", {
  testthat::expect_warning(
    ancho(x),
    'Se eliminaron automáticamente las columnas'
    )
  
})
y <- dplyr::select(x, -usuario, -id_parametro, -parametro, -nombre_clave, 
                   -id_unidad, -uni_nombre, -valor_minimo_str, -id_tipo_dato,
                   -grupo)
test_that("Sin columnas de sobra", {
  testthat::expect_warning(ancho(y), NA)
})

z <- ancho(y)

# ncol(z) == ncol(y) + n.par * 3 - 4
# -4 corresponde a que se van las columnas: valor, limite_* y param
test_that("Se agregan n.par * 3 - 4 columnas", {
  testthat::expect_identical(ncol(z), ncol(y) + n.par * 3L - 4L)
})

y <- dplyr::select(x, -param, -parametro, -id_tipo_dato, -grupo)

test_that("Sin columna param", {
  testthat::expect_warning(
    ancho(y), 'Se creó automáticamente la columna "param"'
    )
})


y <- dplyr::select(x, -param, -parametro, -id_tipo_dato, -grupo, -nombre_clave)

test_that("Sin columnas param o nombre_clave", {
  testthat::expect_error(
    ancho(y), 'No se encontró columna con nombres de parámetros'
  )
})

x <- dplyr::mutate(x, param = nombre_clave) %>%
  dplyr::select(-valor)

test_that("Sin columna valor", {
  testthat::expect_warning(
    ancho(x), 'Se creó automáticamente la columna\\: valor = valor_minimo_str'
    )
})

# x$valor <- x$valor_minimo_str
