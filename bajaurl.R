#búsqueda urls
library(XML)
library(selectr)
library(xml2)
library(rvest)
library(stringr)
library(jsonlite)
library(magrittr)
library(RCurl)
getwd()
###baja url de una lista csv y los scrapea
urlPB <- read.csv("PICTMajo/url.csv", header = FALSE, sep = ",")
lapply(urlPB$V1, function(x){
  url <- as.character(x)
  #crawl
  webpage <- read_html(url, encoding = "UTF-8")
  #scrap just plain text
  doc = htmlParse(webpage, asText=TRUE)
  plain.text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
  NoticiasPP <- capture.output(cat(paste(plain.text, collapse = " ")))
  NoticiasPP1 <- paste0(NoticiasPP, collapse = '\n')
  dire <- "PICTMajo/info/"
  nomal <- format(Sys.time(), "%d-%b-%Y--%H.%M.%S")
  dire1 <- paste(dire,nomal)
  dire2 <- paste(dire1, "txt", sep=".")
  write.table(NoticiasPP1, file = dire2)
})
######
####RCrawler
#######
install.packages("Rcrawler")
library(Rcrawler)
R.Version()
Rcrawler("https://www.vinosyco.com.ar")
?Rcrawler
