# Agregar: antes y después tienen mismas columnas! (y cantidad, obviamente)

# [A] sin NH3L -----
# 
# Procesa muestras con datos únicamente de los parámetros Tem, pH y NH4; se 
# trata de muestras en las que nunca faltan valores para ninguno de estos.
idpnt <- c(2018, 2032, 2090)

muestras <- datos_sia %>% 
  dplyr::filter(id_parametro %in% idpnt, !is.na(valor), tipo_punto_id == 1L) %>% 
  dplyr::count(id_muestra) %>% 
  dplyr::filter(n == 3) %>% 
  dplyr::pull(1)

pnt <- dplyr::filter(datos_sia,
                     id_muestra %in% muestras, 
                     id_parametro %in% idpnt,
                     tipo_punto_id == 1L)

test_that("[A] nrow.in %% 3 == 0", {
  testthat::expect_identical(nrow(pnt) %% 3L, 0L)
})

# nrow(pnt)           # Debe ser múltiplo de 3
# nrow(pnt) %% 3 == 0 # test

pnt.p <- amoniaco_libre_add(pnt)

# La salida debería tener misma cant de columnas que entrada
test_that("[A] ncol.out == ncol.in", {
  testthat::expect_identical(ncol(pnt.p), ncol(pnt))
})


# nrow(pnt.p) %% 4 == 0 # test

# La salida debería tener una cantidad de datos múltiplo de 4:
test_that("[A] nrow.out %% 4 == 0", {
  testthat::expect_identical(nrow(pnt.p) %% 4L, 0L)
})

# El resultado agrega 1 parámetro para todas las muestras que hay en los datos,
# que deberían ser un número múltiplo de 3. Por lo tanto:
test_that("[A] nrow.out = 4/3 * nrow.in", {
  testthat::expect_identical(nrow(pnt.p), 
                             as.integer(4L * nrow(pnt) / 3L))
})


# ACA ESTÁ DANDO MAL: DEBERÍAN SER TODOS n == 4
conteo <- as.integer(table(pnt.p$id_muestra))

test_that("[A] (#params) n x id_muestra en out == 4", {
  testthat::expect_true(all(conteo == 4L))
})

# [B] con NH3L -----
# 
# Procesa muestras con datos de NH3L, además de los parámetros Tem, pH y NH4; se 
# trata de muestras en las que nunca faltan valores para ninguno de estos.
muestras2 <- datos_sia %>% 
  dplyr::filter(id_parametro %in% c(idpnt, 2091)) %>% 
  dplyr::count(id_muestra) %>% 
  dplyr::filter(n == 4) %>% 
  dplyr::pull(1)
nh3 <- datos_sia %>%
  dplyr::filter(id_muestra %in% muestras2, 
                id_parametro %in% c(idpnt, 2091))
nrow(nh3)

test_that("[B] nrow.in %% 4 == 0", {
  testthat::expect_identical(nrow(nh3) %% 4L, 0L)
})

nh3.p <- amoniaco_libre_add(nh3)

# Estos dos dan perfecto:
test_that("[B] nrow.in == nrow.out", {
  testthat::expect_identical(nrow(nh3), nrow(nh3.p))
})

conteo_a <- as.integer(table(nh3$id_muestra))
conteo_b <- as.integer(table(nh3.p$id_muestra))

test_that("[B] (#params) n x id_muestra en in == 4", {
  testthat::expect_true(all(conteo_a == 4L))
})


test_that("[B] (#params) n x id_muestra en out == 4", {
  testthat::expect_true(all(conteo_b == 4L))
})


# d <- dplyr::filter(datos_sia, id_muestra == 3279453, id_parametro %in% idpnt)
# da <- amoniaco_libre_add(d)

# ............ ------
#
# Proglemas: columna usuario ----
#
# ENCONTRÉ: que en esta muestra (la tabla d como se define arriba), a pesar de
# que uno imaginaría que siempre figura el mismo usuario (pues es una única
# muestra), la realidad es que el resultado es:
# d$usuario

# LO SIGUIENTE QUEDA COMENTADO PORQUE LUEGO DE ARREGLAR ancho NO TIENEN SENTIDO
# ESTAS PRUEBAS
# 
# Eso está generando un pivot_wider incorrecto al usar ancho
# 
# Voy a investigar si es sólo con usuarios que pasan estas cosas.
# .data <- filter(datos_sia, 
#                 id_muestra %in% err$id_muestra, 
#                 id_parametro %in% idpnt,
#                 tipo_punto_id == 1L)
# 
# parnec <- c(2032L, 2018L, 2090L)
# 
# w0 <- which(.data$id_parametro %in% parnec)
# 
# tmp <- .data[w0,] %>% 
#     dplyr::mutate(param = dplyr::case_when(
#       id_parametro == 2032L ~ "Tem",
#       id_parametro == 2018L ~ "pH",
#       TRUE ~ "NH4"
#     )) %>%
#     ancho 
# 
# muestras1 <- dplyr::count(tmp, id_muestra)$id_muestra
# 
# tmp <- select(tmp, -starts_with('NH4'), -starts_with('pH'), -starts_with('Tem'))
# 
# columnas <- NULL
# for (i in 1:length(muestras1)) {
#   # cat('Muestra (', i, '): ', muestras1[i], '\n')
#   fila <- filter(tmp, id_muestra == muestras1[i])
#   for (j in 1:ncol(fila)) {
#     uni <- unique(fila[[j]])
#     if (length(uni) > 1) {
#       columnas <- c(columnas, names(fila)[j])
#       print(names(fila)[j])
#     }
#   }
# }
# unique(columnas) == 'usuario' # test para esta prueba únicamente
# 
# Otras posibles columnas conflictivas? ------
# columnasok <- c("nro_muestra", "nombre_programa", "id_programa",
#                 "cue_nombre", "id_cuenca", "sub_cue_nombre", "id_sub_cuenca",
#                 "codigo_pto", "id_estacion", "tipo_punto_id",
#                 "tip_pun_est_descripcion", "id_depto", "departamento",
#                 "id_institucion", "institucion", 
#                 "usuario", # Eliminada en commit del 2/7/2021, porque
#                 # las muestras no tienen porqué tener a un único usuario
#                 # para todos los parámetros.
#                 "periodo", "anio",
#                 "mes", "anio_mes", "fecha_muestra", "fecha_hora",
#                 "id_matriz", "nombre_subcuenca_informes",
#                 "codigo_pto_mod")
# 
# for (i in 1:length(columnasok)) {
#   prueba <- datos_sia %>% 
#     select(tidyselect::all_of(c('id_muestra', columnasok[i]))) %>% 
#     distinct() %>% 
#     count(id_muestra) %>% 
#     filter(n > 1)
#   
#   if (nrow(prueba)) print(columnasok[i])
# }

# Esto confirma que al momento solamente 'usuario' presenta más de un posible
# valor por id_muestra.
# 
# Lo mismo ocurre con datos_sia_sed:
# for (i in 1:(length(columnasok) - 1)) {
#   prueba <- datos_sia_sed %>% 
#     select(tidyselect::all_of(c('id_muestra', columnasok[i]))) %>% 
#     distinct() %>% 
#     count(id_muestra) %>% 
#     filter(n > 1)
#   
#   if (nrow(prueba)) print(columnasok[i])
# }
# ............ -----