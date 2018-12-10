options(encoding = 'UTF-8')

function(input,output,session){
  
  # sauf_jours=c("22/02/2018","25/02/2018")
  
  infos=reactive({
    salle=input$salle
    JxRem=get(x = salle)
    date_facturation=input$mois_annee
    mois=month(date_facturation)
    annee=year(date_facturation)
    header_marine <- readLines("infos_html/marine_olivari.html")%>%enc2native%>%HTML
    
    header_salle <- includeHTML(paste0("infos_html/",salle,".html"))
    # print(JxRem)
    return(list(jr=generation_jours_rem(jours_rem = JxRem,mois = mois,annee = annee),
                header_marine=header_marine,
                header_salle=header_salle))
  })
  
   

  row_removed=data.frame()
  makeReactiveBinding("row_removed")
  
  
  observeEvent(input$table_jours_rem_cell_clicked,{
    row_selected=data.frame(input$table_jours_rem_cell_clicked)
    row_selected=tableau_reac()[row_selected$row,]
    if(!is.null(row_selected)){
      row_removed <<- rbind(row_removed,row_selected)
    }
    output$date_supprimees=renderDataTable({datatable(row_removed,rownames = FALSE, escape = FALSE,options = list(dom = 't'))})
  })
  
  
  observeEvent(input$reset_dates,{
    row_removed <<- data.frame()
  })
  # https://rstudio.github.io/DT/
  tableau_reac=reactive({
    infos_loaded=infos()
    output$header_marine=renderUI({((infos_loaded[[2]]))})
    output$header_salle=renderUI({((infos_loaded[[3]]))})
    tableau=infos_loaded[[1]]
    # print(tableau$paie)
    tableau$jours_du_mois=as.character(tableau$jours_du_mois)
    
    if(nrow(row_removed)>0){
      tableau=tableau[!tableau$jours_du_mois%in%row_removed$jours_du_mois]
    }
    # nb_heures=sum(as.numeric(gsub(" h","",tableau$nb)))
    print(gsub(" ","",tableau$paie))
    paie_totale=sum(as.numeric(gsub(" \u20AC","",tableau$paie)))
    # print(names(tableau))
    tableau <- rbind(tableau,data.frame(
      "jour_de_la_semaine"="", "jours_du_mois"="",     
      "nb"="TOTAL","paie"=paste0(paie_totale," \u20AC")))
    print(tableau)
    tableau
  })
  
  observe({
    tableau=tableau_reac()
    output$table_jours_rem=renderDataTable({datatable(tableau, options = list(dom = 't'),selection = list(target = 'row'),
                                                        rownames = FALSE, escape = FALSE,
                              colnames = c("jour","date","Nombre d'heures","Montant TTC"))})
  })
  
  filenm=function(){paste0("facture",input$mois_annee,input$salle,".html")}
  
  # observeEvent(input$create,{
  #   n_env=new.env(parent = globalenv())
  #   params <- list(header_marine=infos()[[2]],
  #                  header_salle=infos()[[3]],
  #                  date_fac=as.character(input$date_facture),tableau=tableau_reac())
  #   assign("params",params,envir = .GlobalEnv)
  #   # assign(x = "params",value = params,envir = n_env)
  # 
  #   out <- rmarkdown::render(input = 'facture.Rmd',
  #                            output_file = filenm(),#filenm(),
  #                            output_format = "all",
  #                            params = params,
  #                            envir = parent.frame())
  #   out
  # })
  
  output$report <- downloadHandler(
    filename = filenm,contentType = "html",
    content = function(file) {
      print(filenm())
      # src <- normalizePath('facture.Rmd')
      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      # tempReport <- file.path(tempdir(), "report.Rmd")
      # file.copy("report.Rmd", tempReport, overwrite = TRUE)
      # owd <- setwd(tempdir())
      # on.exit(setwd(owd))
      # file.copy(src, 'facture.Rmd', overwrite = TRUE)
      # n_env=new.env(parent = globalenv())
      params <- list(header_marine=infos()[[2]],
                 header_salle=infos()[[3]],
                 date_fac=as.character(input$date_facture),tableau=tableau_reac())
      assign("params",params,envir = .GlobalEnv)
      # assign(x = "params",value = params,envir = n_env)
      
      out <- rmarkdown::render(input = 'facture.Rmd', 
                               output_file = file,#filenm(),
                               output_format = "all",
                               params = params,
                               envir = parent.frame())
      out
      # file.rename(out, file)
    }
  )
  
  

}