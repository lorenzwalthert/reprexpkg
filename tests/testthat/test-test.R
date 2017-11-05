test_that("trivial test", {
  expect_equal(hello(), "Hello, world!")
})

test_that("test with tempdir", {
  file <- tempfile("styler", fileext = ".R")
  enc::write_lines_enc("1++1", file)
  styler::style_file(file, style = styler::tidyverse_style, strict = TRUE)
  second <- styler::style_file(file, transformers = styler::tidyverse_style(strict = TRUE))
  enc::read_lines_enc(file)
  unlink(file)
  expect_false(second)
})


test_that("styler like works", {
  dir <- tempfile("styler")
  dir.create(dir)
  path_temp <- file.path(dir, "repeated_parsing-in.R")
  path_perm <- rprojroot::find_testthat_root_file("parsing", "repeated_parsing-in.R")
  file.copy(path_perm, dir)
  path_out <- styler:::construct_out(path_perm)
  path_out2 <- rprojroot::find_testthat_root_file("parsing", "repeated_parsing-out.R")
  identical(path_out, path_out2)
  #> TRUE
  ref <- enc::read_lines_enc(path_out2) # does not work with path_out
  result <- enc::read_lines_enc(path_temp)
  unlink(dir)
})
