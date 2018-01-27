context("test-my-test.R")

# set test parameters
pkg_repo <- "annakrystalli/rdflib"
review_parent <- file.path(tempdir())
review_dir <- paste0(review_parent, "/rdflib-review")

#  create review project
pkgreview_create(pkg_repo, review_parent, open = F)

test_that("review-proj-created-correctly", {
  expect_true("rdflib-review" %in% list.files(review_parent))
   # expect_true("rdflib-review.Rproj" %in% list.files(review_dir))
})

#  init review project
pkgreview_init(pkg_repo, review_dir, open = F)

cat(list.files(review_dir))

test_that("structure-correct", {
    expect_true("index.Rmd" %in% list.files(review_dir))
    expect_true("pkgreview.md" %in% list.files(review_dir))
    expect_true("R" %in% list.files(review_dir))
    #expect_true("rdflib-review.Rproj" %in% list.files(review_dir))
    expect_true("README.md" %in% list.files(review_dir))
})


test_that("review-files-initialised-correctly", {
    expect_equal(sort(list.files(review_dir)),
                 sort(c("index.Rmd", "pkgreview.md", "R",
                   #"rdflib-review.Rproj",
                   "README.md")))
})

meta <- devtools:::github_remote(pkg_repo)
pkg_dir <- file.path(paste0(review_dir, "/../", meta$repo))
pkgdata <- pkgreview_getdata(pkg_dir)

test_that("check-pkgdata", {
    expect_equal(pkgdata$pkg_repo, "annakrystalli/rdflib")
    expect_equal(pkgdata$index_url, "https://annakrystalli.github.io/annakrystalli/rdflib/index.nb.html")
    expect_equal(pkgdata$review_repo, "annakrystalli/rdflib-review")
    expect_equal(pkgdata$pkgreview_url, "https://github.com/annakrystalli/rdflib-review/blob/master/pkgreview.md")
    expect_equal(pkgdata$issue_url, "https://github.com/ropensci/onboarding/issues/169")
    expect_equal(pkgdata$number, 169)
    expect_equal(pkgdata$whoami, setNames("annakrystalli", "gh_username"))
    expect_equal(pkgdata$whoami_url, "https://github.com/annakrystalli")
    expect_equal(pkgdata$pkg_dir, pkg_dir)
    expect_equal(pkgdata$Package, "rdflib")
    expect_equal(pkgdata$repo, "rdflib")
    expect_equal(pkgdata$site, "https://annakrystalli.github.io/rdflib/")
    expect_false(pkgdata$Rmd)
})