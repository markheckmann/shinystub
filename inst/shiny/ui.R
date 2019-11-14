#////////////////////////////////////////////////////
#
#                       UI
#
#////////////////////////////////////////////////////


suppressWarnings({
  suppressMessages({
    
    library(shiny)
    library(shinyjs)
    library(shinythemes)
    library(shinyWidgets)
    library(shinydashboard)
    library(shinydashboardPlus)
    library(shinycssloaders)
    library(shinyauthr)
    
    library(data.table)
    library(formattable)
    library(openxlsx)
    library(DT)
    library(stringr)
    library(magrittr)
    library(tidyr)
    library(reshape2)
    library(testthat)
    library(scales)
    library(stringr)
    library(tidyverse)
    library(glue)
    library(splines)
    library(plotly)
    library(officer)
    
    library(shinystub)
    
  })
})


#### _______________________####
#### HEADER                 ####


header <- dashboardHeaderPlus(
  title = tagList(
    span(class = "logo-lg",  paste0("shinystub v", packageVersion("shinystub"))), 
    span(class = "logo-sm", "")
  ),
  fixed = FALSE, 
  dropdownMenuOutput("notification_menu")
)


#### _______________________####
#### SIDEBAR                ####

sidebar <- dashboardSidebar(
  
  hidden(
    sidebarMenu(id = "sidebar",
        menuItem("Login", tabName = "tab_login", icon = icon("login") ),
        menuItem("Start", tabName = "tab_start", icon = icon("home") )
    )
  )
)


#### _______________________####
#### BODY                   ####

body <- dashboardBody(
  
  useShinyjs(),             
  tags$head(tags$link(rel = "favicon", href = "favicon.png")), # show favicon
  # custom CSS
  tags$head(tags$style("
  
    .shiny-notification {
      top: 50% !important;
      left: 50% !important;
      margin-top: -100px !important;
      margin-left: -250px !important; 
      font-size: 20px;
    }
    
    .selectize-input {
      min-width: 200px;
      max-height: 200px;
      overflow: auto;
    }
    
    #sidebarItemExpanded .disabled {
      color: #4c5254  !important;
    }

  ")),
  
  tabItems(
    
    #### __ LOGIN  ####
    
    tabItem(tabName = "tab_login",
            shinyauthr::loginUI(id = "login", 
                                title = "Please log in",
                                login_title = "Login",
                                user_title = "User",
                                pass_title = "Password",
                                error_message = "Incorrect user or password!")
    ),
    
    #### __ START  ####
    
    tabItem(tabName = "tab_start",
            fluidRow(
              div( id = "tab_start_text", 
                   box(
                     h2("Welcome"),
                     p("Some text to explain the package."),
                     p("Questions? Email ",
                       tags$a("Mark Heckmann", href = paste0("mailto:heckmann.mark@gmail.com",
                                                             "?subject=Question regarding shinystub v", packageVersion("shinystub"),
                                                             "&body=Your question goes here."))
                      ),              
                     width = 6) 
              ),
              box(width = 6,
              div(style = "font-size:120%", 
                  dataTableOutput("my_datatable") %>% withSpinner(color = "#D33724") 
              ))
            )
    )
    
  ) # end tabitems
) # ende body



#### _______________________####
#### DASHBOARD ####

ui <- dashboardPagePlus(
  title = "shinystub",
  skin = "red",
  header = header,
  sidebar = sidebar,
  body = body
)







