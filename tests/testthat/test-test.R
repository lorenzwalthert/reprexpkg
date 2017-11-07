test_that("trivial test", {
  expect_equal(hello(), "Hello, world!")
})

test_that("test with tempdir", {
  dir <- tempfile("styler")
  dir.create(dir)
  path_temp <- file.path(dir, "repeated_parsing-in.R")
  path_perm <- rprojroot::find_testthat_root_file("repeated_parsing-in.R")
  file.copy(path_perm, dir)
  path_out <- gsub("\\-.*$", "\\-in\\.R", path_perm)
  identical(path_out, path_perm)
  #> TRUE
  ref <- enc::read_lines_enc(path_out) # does not work with path_out, only works with path_term
  unlink(dir)
})
