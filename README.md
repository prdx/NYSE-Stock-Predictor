# Pre-requisites
1. Docker
2. `install.package(plumber)`

# Project structure

## Boilerplate for the API

The root file for the API is R/app.R, we define the other files we want to load there. 

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

