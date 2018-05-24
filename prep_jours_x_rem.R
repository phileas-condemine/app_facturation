options(encoding = 'UTF-8')
# https://en.wikipedia.org/wiki/List_of_Unicode_characters
senat_jazz=data.frame(jour_de_la_semaine=c("vendredi"),
                      nb=paste(c(1),"h"),
                      paie=paste(c(75),"\u20AC"))

senat_stretch=data.frame(jour_de_la_semaine=c("mardi","vendredi"),
                         nb=paste(c(1),"h"),
                         paie=paste((75),"\u20AC"))

pdv=data.frame(jour_de_la_semaine=c("mercredi","vendredi"),
               nb=c("2h15","2h15"),
               paie=paste(c(2.25*35,2.25*35),"\u20AC"))

ansm=data.frame(jour_de_la_semaine=c("lundi","jeudi"),
                nb=paste(c(2,1),"h"),
                paie=paste(c(2*70,70),"\u20AC"))

dauphine=data.frame(jour_de_la_semaine=c("mercredi"),
                    nb=paste(c(1),"h"),
                    paie=paste(c(35),"\u20AC"))

st_laz=data.frame(jour_de_la_semaine=c("lundi","jeudi"),
                  nb=paste(c(1,2),"h"),
                  paie=paste(c(35,70),"\u20AC"))

bastille=data.frame(jour_de_la_semaine=c("samedi"),
                          nb=c("1h30"),
                          paie=paste(35*1.5,"\u20AC"))

ornano=data.frame(jour_de_la_semaine=c("samedi"),
                    nb=c("1h15"),
                    paie=paste(35*1.25,"\u20AC"))