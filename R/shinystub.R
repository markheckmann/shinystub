

#' \pkg{shinystub} - shinystub
#'  
#' @keywords package shinystub
#' @name shinystub-package
#' @docType package
#' @import 
#' shiny 
#' shinyjs 
#' shinyBS 
#' shinythemes
#' shinyWidgets
#' shinydashboard
#' shinydashboardPlus
#' shinycssloaders
#' data.table
#' formattable
#' openxlsx
#' DT
#' stringr
#' magrittr
#' tidyverse
#' tidyr
#' reshape2
#' testthat
#' scales
#' stringr
#' ggplot2
#' dplyr
#' splines
#' crayon
#' plotly
#' readxl
#' magrittr
#' officer
NULL


#' launch shinystub
#'
#' @param display.mode \code{auto} by default, can also be \code{showcase}. See
#'   \link[shiny]{runApp}.
#' @param launch.browser Boolean, set \code{TRUE} (default) to open the app in
#'   the browser. See \link[shiny]{runApp}.
#' @export
#' @import shiny
#' @import shinythemes
#' @import shinyBS
#' @examples
#' \dontrun{
#' shinystub()
#' }
shinystub <- function(display.mode = "auto",
                    launch.browser = TRUE) 
{
  appDir <- system.file("shiny", package = "shinystub")
  if (appDir == "") {
    stop("Could not find shiny directory. Try re-installing `shinystub`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = display.mode, launch.browser = launch.browser)
}








