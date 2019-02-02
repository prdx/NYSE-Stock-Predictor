[![Build Status](https://travis-ci.com/prdx/DS5110-final-project.svg?token=Bku4c8XtGXoto53hwmYA&branch=master)](https://travis-ci.com/prdx/DS5110-final-project)

# Pre-requisites
1. Docker
2. `install.package(plumber)`
2. `install.package(testthat)`

# Project structure

The root codes file for the API is R/app.R, we define the other files we want to load there. 

The root folder for test files is tests/testthat. It has a naming convention: test-your_file_name.R

in anotherTest.R
```
#' @post /sum
addTwo <- function(a, b){
  as.numeric(a) + as.numeric(b)
}
```

There we can put any related function in the same file, and define the endpoint in the app.R

```
# Endpoint /calculations
another_test <- plumber$new("anotherTest.R")
app$mount("/calculations", another_test)
```

And the endpoint will be `/calculations/sum`.
To try it you can: `curl --data '{"a":4, "b":5}' http://localhost:8000/calculations/sum` after you run the app.R

# How to
Docker build: `docker build .`
Run the app: `Rscript R/app.R` 
Run the test: From R console, you can run `testthat::test_dir("tests/testthat")`, assuming your working directory in the root folder of the projects.


