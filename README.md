# Robust Confidence Ellipsoid

It is a statistical method for outlier detection in a multivariate data set. This repository provides a R code for build it.

```r
# If necessary
# install.packages(c("xlsx", "plotly", ""))

# Load packages
library(xlsx)
library(plotly)

# Load function from GitHub
path = "https://github.com/luizleal1974/Robust-Confidence-Ellipsoid/raw/main/RCE.R"
devtools::source_url(path)

# Load data set from GitHub
arquivo = tempfile(fileext = ".xlsx")
path = "https://github.com/luizleal1974/Robust-Confidence-Ellipsoid/raw/main/data.xlsx"
download.file(path, destfile = arquivo, mode = 'wb')
dfr = read.xlsx(arquivo, sheetIndex = 1, encoding = "UTF-8")

# Axes features
axyz = list(title = list(font = list(size = 17, color = 'black')),
            gridcolor = 'rgb(255, 255, 255)',
            zerolinecolor = 'rgb(255, 255, 255)',
            showbackground = TRUE,
            backgroundcolor = 'rgb(240, 240, 240)',
            tickfont = list(size = 13, color = "black")
            )

# Significance level
alpha = 0.05

# Robust Confidence Ellipsoid
elipsoide = ellipsoid(dfr[,"x"],
                      dfr[,"y"],
                      dfr[,"z"],
                      segments = 51,
                      robust = TRUE,
                      level = (1-alpha))
plot_ly(data = as.data.frame(elipsoide),
        x = ~x,
        y = ~y,
        z = ~z,
        type = 'mesh3d',
        opacity = 0.5,
        alphahull = 0,
        name = 'Ellipsoid') %>%
add_text(x = dfr[,"x"],
         y = dfr[,"y"],
         z = dfr[,"z"],
         text = ~dfr[,1],
         opacity = 0.5,
         textfont = list(family = "sans serif", size = 18, color = toRGB("black")),
         textposition = "middle center",
         name = 'Object') %>%
layout(title = paste("\n", "<b>", (1-alpha)*100, "% Robust Confidence Ellipsoid</b>" , sep=""),
       plot_bgcolor = 'rgb(240, 240, 240)',
       scene = list(xaxis = axyz, yaxis = axyz, zaxis = axyz))
```

# Citation

Please cite the following thesis when using `RCE.R`:

LEAL, Luiz Henrique da Conceição. <b>Aplicativo web para avaliação de desempenho de laboratórios.</b> 2022. 146f. Tese (Doutorado em Metrologia) – Instituto Nacional de Metrologia, Qualidade e Tecnologia, Duque de Caxias, RJ, 2022.
