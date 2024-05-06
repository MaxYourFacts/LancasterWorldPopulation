#' Graph a country's population
#'
#' This function will display the graph the years 1950 to 2020 of an inputed
#' country's population
#' @param countryName An input string
#' @return A graph
#' @examples
#' CountryPopulation('United States of America')
#' @export
CountryPopulation <- function(countryName){
  if(!(countryName %in% WorldPopulation$`Country Name`)){
    stop('Country inputed is not in dataset')
  }

  countryData <- WorldPopulation %>%
    filter(WorldPopulation$'Country Name' %in% c(countryName)) %>%
    pivot_longer('1950':'2020',names_to='Year',values_to='Population')

  graph <- countryData %>%
    ggplot(aes(x=Year,y=Population,group='Country Name')) +
    geom_line() +
    scale_x_discrete(breaks=seq(1950,2020,by=10)) +
    labs( x="Year", y="Population (in Thousands)") +
    labs(title= paste(countryName, "Population Graph from 1950 to 2020"))

  return(graph)
}
