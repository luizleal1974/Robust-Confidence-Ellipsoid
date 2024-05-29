# Function
f = function(x, tab = TRUE, plt = FALSE){
result = data.frame(prop.table(table(x)))
library(plotly) ; p = plot_ly(x = x, type = "histogram", marker = list(color = "#69b3a2", line = list(color = "black", width = 2))) 
if(tab == TRUE){return(result)}
if(plt == TRUE){print(p)}
}

# Data set
values = c(0, 1, 2, 3, 3, 4, 4, 5, 5, 5, 5, 6, 6, 7, 8, 9)

# Output
f(x = values, tab = TRUE, plt = FALSE)
f(x = values, tab = FALSE, plt = TRUE)
