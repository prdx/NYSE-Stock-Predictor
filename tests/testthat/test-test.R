source("../../R/test.R")
context("This is a sample test")

test_that("Check if the function returns a string", {
	expect_equal(test(), "<html><h1>hello world</h2></html>")
	})
