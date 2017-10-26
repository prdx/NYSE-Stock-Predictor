library("plumber")

app <- plumber$new()

# Define the routing for each files
test <- plumber$new("test.R")

# Endpoint /hello
app$mount("/hello", test)

# Endpoint /calculations
another_test <- plumber$new("anotherTest.R")
app$mount("/calculations", another_test)


app$run(port=8000)
