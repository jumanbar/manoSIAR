#' Lista de departamentos
#'
#' La tabla de departamentos tiene los 19 departamentos de Uruguay y 2 entradas
#' extra: "DATO MIGRADO" y "---" (codigos "XX" y "NN" respectivamente). Las
#' estaciones del programa de monitoreo "Laguna Garzón" presentan esta categoría
#' en la columna "departamento" (Se encuentran entre Maldonado y Rocha).
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla con 21 filas y 3 columnas:
#'
#' \describe{
#'
#'   \item{id}{}
#'
#'   \item{dep_nombre}{Nombre del departamento}
#'
#'   \item{dep_codigo}{Código o abreviación del nombre del departamento}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_departamento"



#' Estaciones de monitoreo
#'
#' Es la lista completa de estaciones de monitoreo para las matrices Aguas
#' superficiales y Sedimentos. Incluye las columnas \code{prog_monitoreo} y
#' \code{matriz_estacion}, las cuales son la razón por las cuales las estaciones
#' son usadas como referencia para adivinar si un conjunto de datos pertenece a
#' una determinada matriz y programa. También se usa para determinar la matriz
#' de cada programa de monitoreo.
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla con 433 filas y 17 columnas:
#'
#'   \describe{
#'
#'   \item{codigo_pto}{Código de letras y números para cada estación}
#'
#'   \item{estacion}{Nombre de la estación (largo; puede ser una descripción de
#'   cómo llegar, etc...)}
#'
#'   \item{latitud}{}
#'
#'   \item{longitud}{}
#'
#'   \item{gid}{Identificador único (número entero) para el contexto de trabajo
#'   con GIS}
#'
#'   \item{id_playa}{no sé}
#'
#'   \item{prog_monitoreo}{Identificador único (id) del programa de monitoreo
#'   correspondiente a cada estación.}
#'
#'   \item{id}{Identificador único (número entero) de la estación.}
#'
#'   \item{version}{no sé}
#'
#'   \item{tipo_punto_id}{Número que indica el id del tipo de muestras tomadas:
#'   superficie o fondo (1 o 2 respectivamente)}
#'
#'   \item{estacion_asociada_id}{no sé}
#'
#'   \item{departamento}{Número que indica el id del departamento en el que se
#'   encuentra la estación}
#'
#'   \item{sub_cuenca}{Número que indica el id de la subcuenca en el que se
#'   encuentra la estación}
#'
#'   \item{orden_ingreso}{no sé}
#'
#'   \item{ingreso_interno}{no sé}
#'
#'   \item{matriz_estacion}{Número que indica el id de la matriz asociada a la
#'   estación (de momento: 6 = Aguas superficiales y 11 = Sedimentos;
#'   15/10/2020)}
#'
#'   \item{estacion_activa}{no sé}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_estacion"



#' Lista de instituciones
#'
#' Instituciones asociadas a los usuarios que suben los datos al SIA.
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla con 27 filas y 2 columnas:
#'
#' \describe{
#'
#'   \item{id_institucion}{Número único (natural) para cada institución.}
#'
#'   \item{nombre}{Nombre de la institución (texto).}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_institucion"


#' Lista de matrices ambientales
#'
#' La tabla tiene los nombres y abreviaciones de las matrices ambientales
#' definidas e infambientalbd, así como el id único de cada clase.
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla de 15 filas y 5 columnas:
#'
#' \describe {
#'
#'   \item{id_matriz}{}
#'
#'   \item{nombre}{Nombre de la matriz}
#'
#'   \item{codigo}{Código o nombre corto de la matriz}
#'
#'   \item{vigente}{no sé}
#'
#'   \item{fca_habilitado}{no sé}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_matriz"



#' Lista de correspondencias entre parámetros y unidades
#'
#' Tabla que vincula cada parámetro con su unidad correspondiente, según la
#' matriz ambiental. Necesaria para conectar \code{\link{sia_parametro}} con
#' \code{\link{sia_unidad}}
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla de 1321 filas y 4 columnas:
#'
#' \describe {
#'
#'   \item{id}{identificador único para las entradas de esta tabla (i.e.:
#'   combinaciones de `id_unidad_medida`, `id_parametro` e `id_matriz`)}
#'
#'   \item{id_unidad_medida}{Número que indica el id de la unidad de medida
#'   correspondiente}
#'
#'   \item{id_parametro}{Número que indica el id del parámetro correspondiente}
#'
#'   \item{id_matriz}{Número que indica el id de la matriz ambiental
#'   correspondiente}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_param_unidad"

#' Lista de parámetros de SIA
#'
#' Tabla con todo los parámetros contemplados por la base de datos
#' infambientalbd. Para conectarla con \code{\link{sia_unidad}}, es necesaria la
#' tabla \code{\link{sia_param_unidad}}.
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla de 356 filas y 7 columnas:
#'
#'   \describe{
#'
#'   \item{id_parametro}{id: número natural único para cada fila}
#'
#'   \item{parametro}{Nombre (largo) del parámetro. Puede ser una frase corta.
#'   Texto.}
#'
#'   \item{enumerado}{no sé}
#'
#'   \item{nombre_clave}{Nombre corto o código creado para cada parámetro
#'   (debería ser único). Texto.}
#'
#'   \item{decimales}{no sé}
#'
#'   \item{par_vigente}{no sé}
#'
#'   \item{codigo_airviro}{no sé}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_parametro"



#' Lista de programas de monitoreo
#'
#' Los programas de monitoreo registrados en el SIA (base de datos
#' infambientalbd). Corresponden a las matrices ambientales "Aguas
#' superficiales" y "Sedimentos"
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla de 32 filas y 6 columnas:
#'
#' \describe{
#'
#' \item{id_programa}{\code{integer}. Número único para cada programa.}
#'
#' \item{nombre_programa}{Nombre (largo) del programa de monitoreo}
#'
#' \item{codigo_programa}{Código (corto) que identifica a cada programa}
#'
#' \item{visible_externos}{no sé}
#'
#' \item{version}{no sé}
#'
#' \item{id_programa_silad}{no sé}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_programa"


#' Relación entre programas y parametros
#'
#' Tabla que (intenta) registrar los parametros que son monitoreados en cada
#' programa.
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla con 1458 filas y 3 columnas:
#'
#'   \describe{
#'
#'   \item{id}{Identificador único para las entradas de esta tabla}
#'
#'   \item{id_programa}{Identificador de programa}
#'
#'   \item{id_parametro}{Identificador de parametro}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_programa_parametro"

#' Tipo de estacion
#'
#' Tipos de estaciones de monitoreo, según (la profundidad de) las muestras que
#' se toman
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla con 2 entradas y 3 columnas:
#'
#'   \describe{
#'
#'   \item{id}{Identificador único para las entradas de esta tabla}
#'
#'   \item{tip_pun_est_descripcion}{Descripción del tipo de punto ("SUPERFICIE"
#'   o "FONDO")}
#'
#'   \item{tip_pun_est_codigo}{Identificador único (númerico) del tipo de punto:
#'   superficie o fondo (1 o 2 respectivamente)}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_tipo_punto_estacion"


#' Lista de las unidades de medidas contempladas por el SIA
#'
#' La tabla oficial de unidades de medida registradas en el SIA. Para vincular
#' las unidades con \code{\link{sia_parametro}} es necesaria la tabla
#' \code{\link{sia_param_unidad}}
#'
#' Fecha de extraccion: 2020-10-22
#'
#' @format Tabla con 1321 filas y 4 columnas:
#'
#'   \describe{
#'
#'   \item{id}{integer. Identificador único de cada unidad de medida.}
#'
#'   \item{uni_nombre}{Texto para cada unidad de medida (ej: "mg CaCO3/L")}
#'
#'   \item{uni_factor_conversion}{no sé}
#'
#' }
#'
#' @source \code{infambientalbd}
"sia_unidad"
