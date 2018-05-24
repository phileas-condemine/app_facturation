options(encoding = 'UTF-8')
library(shiny)
library(data.table)
library(dplyr)
library(DT)
library(htmltools)
library(knitr)
library(rmarkdown)
require(lubridate)
d <- as.Date('2004-01-01')
month(d) <- month(d) + 1
day(d) <- days_in_month(d)
d

Sys.setlocale('LC_TIME', "French_France")
mois=04
annee=2018
generation_jours_rem=function(jours_rem,mois,annee){
  premier_jour=as.Date(paste("01",mois,annee,sep="/"),"%d/%m/%Y")
  dernier_jour=premier_jour
  day(dernier_jour) <- days_in_month(dernier_jour)
  jours_du_mois=seq(from = premier_jour,to = dernier_jour,by=1)
  
  JDM_df=data.frame(jours_du_mois=jours_du_mois,week_start=1,
                    jour_de_la_semaine=wday(jours_du_mois,label=T,week_start = getOption("lubridate.week.start", 1)))
  JDM_df$week_start=NULL
  levels(JDM_df$jour_de_la_semaine) <- c("lundi","mardi","mercredi","jeudi","vendredi","samedi","dimanche")
  
  # print(head(JDM_df))
  # print(head(jours_rem))
  JT_rem=merge(JDM_df,jours_rem,by="jour_de_la_semaine")
  JT_rem%>%
    arrange(jours_du_mois)%>%
    data.table
}

source("prep_jours_x_rem.R")
salles_cours=c("ansm","dauphine","pdv","senat_jazz","senat_stretch","st_laz","bastille","ornano")


