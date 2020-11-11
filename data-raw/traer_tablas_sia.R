# INFAMBIENTAL ----
drv <- DBI::dbDriver("PostgreSQL")

pw <- {
  "shiny_passwd"
}

nodo <- Sys.info()["nodename"]
prueba <- grepl("DINAMA", nodo, ignore.case = TRUE)

if (prueba) {
  con <- RPostgreSQL::dbConnect(drv, dbname = "infambientalbd",
                                host = "172.20.0.34", port = 5432,
                                user = "shiny_usr", password = pw)
  # Para trabajar en la máquina windows de la oficina, en donde ya sé que la
  # codificación de caracteres es WIN1252 (en verdad Sys.getlocale() dice
  # "Spanish_Uruguay.1252", pero asumo que es lo mismo y en las pruebas que hice
  # anduvo bien):
  if (grepl("DINAMA-OAN11", nodo, ignore.case = TRUE)) {
    # dbExecute(con, "SET CLIENT_ENCODING TO 'WIN1252';")
    RPostgreSQL::dbExecute(con, "SET NAMES 'WIN1252';")
  }
  
} else {
  # En caso de estar en una computadora sin conexión a la base de datos, se usa
  # un respaldo de las tablas importantes.
  # load('data/liteTablas.RData')
  con <- RPostgreSQL::dbConnect(drv, dbname = 'infambientalbd', 
                                host = 'localhost', port = 5432, user = 'juan',
                                password = 'shiny')
  
}

# @ sia_parametro ----
sia_parametro <- dplyr::tbl(con, "parametro")
if (exists("todos_param")) {
  if (!todos_param) {
    muestras_param <-
      dplyr::tbl(con, "datos_muestra_parametros") %>%
      dplyr::select(id_parametro, valor_minimo_str,
             limite_deteccion, limite_cuantificacion) %>%
      dplyr::collect() %>%
      valores_numericos(metodo = "simple", filtrar_no_num = TRUE) %>%
      dplyr::count(id_parametro)
    
    sia_parametro <-
      sia_parametro %>%
      dplyr::filter(id_parametro %in% !!muestras_param$id_parametro)
  }
}
sia_parametro <- dplyr::collect(sia_parametro)
save(sia_parametro, file="data/sia_parametro.rda")

# @ sia_matriz ----
sia_matriz <- dplyr::collect(dplyr::tbl(con, "matriz"))
save(sia_matriz, file="data/sia_matriz.rda")

# @ sia_param_unidad ----
#
# Tiene algunas diferencias con sia_param_unidad que tenía yo grabada. Estas
# diferencias pueden ver con anti_join: 21 casos presentes en db_ pero no en
# sia_, y 10 casos presentes en sia_ que no están en db_.
#
# anti_join(db_param_unidad, sia_param_unidad) # 21 filas
# anti_join(sia_param_unidad, db_param_unidad) # 10 filas
sia_param_unidad <- dplyr::collect(dplyr::tbl(con, "param_unidad"))
save(sia_param_unidad, file="data/sia_param_unidad.rda")

# @ sia_unidad ----
#
# anti_join(db_unidad, sia_unidad)
# anti_join(sia_unidad, db_unidad) # 2 filas
sia_unidad <- dplyr::collect(dplyr::tbl(con, "unidad"))
save(sia_unidad, file="data/sia_unidad.rda")

# @ sia_programa ----
sia_programa <- 
  dplyr::tbl(con, "programa") %>% 
  dplyr::arrange(id_programa) %>% 
  dplyr::collect()
save(sia_programa, file="data/sia_programa.rda")

# @ sia_departamento ----
sia_departamento <- dplyr::collect(dplyr::tbl(con, "departamento"))
save(sia_departamento, file="data/sia_departamento.rda")

# @ sia_estacion ----
sia_estacion <- 
  dplyr::tbl(con, "estacion") %>% 
  dplyr::arrange(id) %>% 
  dplyr::collect()
save(sia_estacion, file="data/sia_estacion.rda")

# @ sia_tipo_punto_estacion ----
sia_tipo_punto_estacion <-
  dplyr::tbl(con, "tipo_punto_estacion") %>% 
  dplyr::arrange(id) %>% 
  dplyr::collect()
save(sia_tipo_punto_estacion, file="data/sia_tipo_punto_estacion.rda")

# @ sia_institucion ----
sia_institucion <- dplyr::collect(dplyr::tbl(con, "institucion"))
save(sia_institucion, file="data/sia_institucion.rda")

# @ sia_programa_parametro ----
sia_programa_parametro <- dplyr::collect(dplyr::tbl(con, "programa_parametro"))
save(sia_programa_parametro, file="data/sia_programa_parametro.rda")

# @ usuarios ----
usuarios <-
  dplyr::tbl(con, "muestra") %>%
  dplyr::distinct(usuario) %>%
  dplyr::arrange(1L) %>%
  dplyr::collect()
save(usuarios, file="data/usuarios.rda")

# @ sia_muestra ----
sia_muestra <- dplyr::collect(dplyr::tbl(con, "muestra"))
save(sia_muestra, file="data/sia_muestra.rda")

# @ sia_datos_muestra_parametros -----
sia_datos_muestra_parametros <- 
  dplyr::collect(dplyr::tbl(con, "datos_muestra_parametros"))
save(sia_datos_muestra_parametros, file="data/sia_datos_muestra_parametros.rda")
