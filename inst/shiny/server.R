#////////////////////////////////////////////////////
#
#                     server
#
#////////////////////////////////////////////////////

library(shiny)
library(shinyjs)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)
library(shinydashboardPlus)
library(shinycssloaders)
library(shinyauthr)


# shared variables across users
users = reactiveValues(count = 0)

# dataframe that holds usernames, passwords and other user data
user_base <- data.frame(
  user = c("admin"),
  password = c("admin"), 
  permissions = c("standard"),
  name = c("Admin"),
  stringsAsFactors = FALSE,
  row.names = NULL
)

SHOW_LOGIN <- F   # set FALSE for dev puposes 


server <- function(input, output, session) 
{
  
  #### .                       ####
  #### _______________________ ####
  #### LOGIN  ####
  
  # keep track of number of users
  onSessionStart = isolate({
    users$count = users$count + 1
  })
  
  onSessionEnded(function() {
    isolate({
      users$count = users$count - 1
    })
  })
  
  
  # call the logout module with reactive trigger to hide/show
  if (SHOW_LOGIN) {
    logout_init <- callModule(shinyauthr::logout, id = "logout", 
                              active = reactive(credentials()$user_auth))
    
    # call login module supplying data frame, user and password cols and reactive trigger
    credentials <- callModule(shinyauthr::login, 
                              id = "login", 
                              data = user_base,
                              user_col = user,
                              pwd_col = password,
                              log_out = reactive(logout_init()))    
  } else {
    # suppress for dev purposes
    credentials <- reactive({
      list(user_auth = T)
    })
  }
  
  
  # on login / logout
  observe({
    if (isTRUE(credentials()$user_auth)) {
      # on Login
      cat("\nUI update on login")
      show(selector = ".sidebar-menu")
      show("sidebarCollapsed")
      hide(selector = '[data-value="tab_login"]')
      removeClass(id = "logout-button", class = "shinyjs-hide")
      updateTabItems(session, "sidebar", "tab_start")
    } else {
      # on Logout
      cat("\nUI update on logout")
      hide("sidebarCollapsed")
      updateTabItems(session, "sidebar", "tab_login")
    }
  })
  
  
  #### .                       ####
  #### _______________________ ####
  #### NOTIFICATIONS ####

  # no users and logout button  
  output$notification_menu <- renderMenu(
  {
    msg <- messageItem( from = "", 
                        message = paste("Number of current users:", users$count),
                        icon = icon("users"))
    logout <- tags$li(shinyauthr::logoutUI(id = "logout", label = "Logout"))
    dropdownMenu(msg, logout, icon = icon("users"), type = "messages", headerText = "")
  })
  

  #### .                       ####
  #### _______________________ ####
  #### TABLES ####
  
  output$my_datatable = renderDataTable(
  {
    if (is.null(input$my_dataframe)) {
      Sys.sleep(1)
      res <- dt_default("Waiting for data ...")
    } else {
      # add logic here
    }
    res
  })
  
}


