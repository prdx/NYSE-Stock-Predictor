FROM rocker/r-base
MAINTAINER Bagus Trihatmaja <trihatmaja.a@husky.neu.edu>


RUN apt-get update -qq && apt-get install -y \
  git-core \
  libssl-dev \
  libcurl4-gnutls-dev

RUN R -e 'install.packages(c("plumber", "tibble", "dplyr", "readr", "purrr", "modelr"))'

EXPOSE 8000
RUN mkdir app
ADD R app/R
ADD data app/data
WORKDIR app
CMD ["R", "-e", "source('R/app.R')"]

