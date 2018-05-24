options(encoding = 'UTF-8')

bootstrapPage(
  tags$head(
    # Include our custom CSS
    includeCSS("style.css")
  ),
  tags$div(class="row",
           tags$div(class="col-sm-4",
                selectInput(inputId="salle",label = "Facture pour quelle salle ?",
                               choices = salles_cours)),
           tags$div(class="col-sm-4",
             dateInput(inputId = "mois_annee",format = "yyyy-mm-dd",startview ="year",
                       label = "Mois à facturer",value = format(Sys.time(), '%Y-%m-%d')
               )),
           tags$div(class="col-sm-4",
                    dateInput(inputId = "date_facture",format = "yyyy-mm-dd",startview ="month",
                              label = "Date à afficher pour la facturation",value = format(Sys.time(), '%Y-%m-%d')
                    )),
           tags$div(class="col-sm-4",
                    absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                  draggable = TRUE, top = 50, left = "auto", right = 20, bottom = "auto",
                                  width = "auto", height = "auto",
                                  HTML('<button data-toggle="collapse" data-target="#etablissements">I/O</button>'),
                                  tags$div(id="etablissements",
                                           class="collapse",
                                           tags$div(class="col-sm-2",h1("Lignes supprimées")),
                                           tags$div(class="col-sm-2",actionButton("reset_dates","Restaurer")),
                                           dataTableOutput("date_supprimees")
                                  )
                    )
           )
                    
           # https://rstudio.github.io/DT/shiny.html
           # https://yihui.shinyapps.io/DT-rows/
           ),
  tags$div(class="row",
           tags$div(class="col-sm-6",htmlOutput("header_marine")),
           tags$div(class="col-sm-6",htmlOutput("header_salle"))),
  tags$div(dataTableOutput("table_jours_rem")),
  tags$div(downloadButton("report"))
  # tags$div(actionButton("report", "export_pdf"))
  
)




