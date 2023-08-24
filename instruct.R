# Obtendo as bases de dados


library(bibliometrix)
library(dplyr)

# Importar os dados ----
# A próxima etapa é importar os dados. A função para importar é bibliometrix::convert2df(), sendo importante informar como argumento: o caminho até o arquivo a ser aberto, a fonte dos dados (dbsource) e o formato do arquivo.

# CARREGAR O BANCO DE DADOS ----

# Os dados exportados do scopus são mais simples, pois é apenas um arquivo:
dados_scopus <- bibliometrix::convert2df("dados/scopus.csv", dbsource = "scopus", format = "csv")
dplyr::glimpse(dados_scopus)

dados_wos <- bibliometrix::convert2df("dados/savedrecs.bib", dbsource = "isi", format = "bibtex")
dplyr::glimpse(dados_wos)

dados_eric <- bibliometrix::convert2df("dados/eric.bib", dbsource = "pubmed", format = "bibtex")

# união dos dados e exclusão das duplicatas ----
dados_brutos <- bibliometrix::mergeDbSources(dados_scopus, dados_wos, remove.duplicated = TRUE)

# Análise Bíbliométrica ----
results <- bibliometrix::biblioAnalysis(dados_brutos, sep = ";")
bibliometrix::sumary(object = results, k = 10, pause = FALSE)
?summary
# resumo: resume os principais resultados da análise
options(width=100)
S <- bibliometrix::sumary(object = results, k = 10, pause = FALSE)


# Para importar os dados do Wos, utilizei os passos abaixo:
# listar arquivos que preciso abrir:
# todos eles começam com o padrão "savedrecs_"
arquivos_wos <- list.files("dados", pattern = "^savedrecs_", full.names = TRUE)

arquivos_wos

# Utilizando esse vetor de caminhos até os arquivos, utilizamos a função convert2df para importá-los

dados_wos <- bibliometrix::convert2df(dados/arquivos_wos, dbsource = "wos", format = "bibtex")

# ERIC
# dados_wos <- bibliometrix::convert2df(arquivos_eric, dbsource = "wos", format = "bibtex")

# união dos dados e exclusão das duplicatas ----
dados_brutos <- bibliometrix::mergeDbSources(dados_scopus, dados_eric, dados_wos, remove.duplicated = TRUE)

# Análise Bíbliométrica
results <- bibliometrix::biblioAnalysis(dados_brutos, sep = ";")


# resumo: resume os principais resultados da análise
options(width=100)
S <- bibliometrix::sumary(object = results, k = 10, pause = FALSE)


glimpse(dados)

library(knitr)
kable(head(dados, 10), col.names =  c("nome"))

# tabela do pacote padrão
library(rmarkdown)
paged_table(dados)

kableExtra
