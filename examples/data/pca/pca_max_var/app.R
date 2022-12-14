library("shinydashboard")

index <- sample(nrow(faithful), 30)
zx    <- scale(faithful$eruptions)
zy    <- scale(faithful$waiting)
xlim  <- range(zx)
ylim  <- range(zy)

makeTable <- function(tab) {
  ret <- ''
  if (length(tab)) {
    cmp     <- (names(tab)=="")
    nonames <- is.na(cmp) | cmp
    names   <- ifelse(nonames, '', paste0('<tr><td bgcolor="#CCCCCC">', names(tab), '</td></tr>'))
    values  <- paste0('<tr><td align="right">', tab, '</td></tr>')
    ret     <- paste0('<table width="100%">', paste0(names, values, collapse=''), '</table>')
  }
  ret
}

ui <- dashboardPage(
  dashboardHeader(title = "MM*Stat"),
  dashboardSidebar(
    sliderInput("angle", "Line angle (in degree)", 0, 180, 90)
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("outputPlot"), title="PCA - Maximizing variance", width=9),
      box(tableOutput("outputValues"), width=3)
    )
  )
)

server <- function(input, output) {
  
  values <- reactiveValues(table=c())
  
  output$outputPlot <- renderPlot({
    layout(matrix(c(1,1,2), 3, 1))
    plot(zx[index], zy[index], pch=19, asp=1, xlim=xlim, ylim=ylim,
         main="Subsample of Old Faithful geyser data", xlab="Eruption time (standardized)", ylab="Waiting time (standardized)")
    usr   <- par('usr')
    dy    <- sin(pi*input$angle/180)
    dx    <- cos(pi*input$angle/180)
    t0    <- max(min(usr[3:4]/dy), min(usr[1:2]/dx)) 
    t1    <- min(max(usr[3:4]/dy), max(usr[1:2]/dx)) 
    lines(dx*c(t0,t1),dy*c(t0,t1), col="blue")
    t     <- zx[index]*dx+zy[index]*dy
    points(dx*t, dy*t, pch=19, cex=0.75, col="blue")
    error <- 0
    for (i in seq(index)) {
      lines(c(dx*t[i], zx[index[i]]), c(dy*t[i], zy[index[i]]), col="lightblue")
      error <- error + sqrt((dx*t[i]-zx[index[i]])*(dx*t[i]-zx[index[i]])+(dy*t[i]-zy[index[i]])*(dy*t[i]-zy[index[i]]))
    }
    zmax <- max(sqrt(zx*zx+zy*zy))
    boxplot(t, ylim=c(-zmax, zmax), horizontal=T, col.border="grey", medcol="white", main="Projected data points")
    stripchart(t, method="jitter", add=T, col="blue", pch=19)
    
    tab <- c(sprintf("%.2f", error), sprintf("%.2f", var(t)), sprintf("%.0f%%", 100*var(t)/(var(zx[index])+var(zy[index]))))
    names(tab) <- c("Total distance", "Variance of projected data points", "Explained total variance")
    values$table <- tab
  })
  
  output$outputValues <- renderText({
    makeTable(values$table)
  })
  
  
}

shinyApp(ui, server)