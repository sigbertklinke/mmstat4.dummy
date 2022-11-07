# mmstat4.dummy

This repository contains an exercept of  teaching materials for statistics courses at the Chair of Statistics by Sigbert Klinke and Bernd Rönz at the Humboldt University of Berlin.

These include:

* Lecture notes as well as
* programmes and interactive apps. 

You have to expect that the contents of the repository will be updated about every 6 months (after the semester end).


For usage in R:

```
# devtools::install_github("sigbertklinke/mmstat4")
library("mmstat4")
ghget("dummy")
ghlist("\\.pdf$") # find all PDFs
ghopen("Aufgaben.pdf")
```