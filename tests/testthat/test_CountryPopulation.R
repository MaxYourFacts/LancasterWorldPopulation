context('Was Graphed')

test_that('Raises Errors', {
  testCountry <- 'Fake Country'
  testCountry2 <- 'USA' #Not precisely in Country Name column

  expect_error(CountryPopulation(testCountry))
  expect_error(CountryPopulation(testCountry2))
})
