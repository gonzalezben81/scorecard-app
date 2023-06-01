# get shiny serves plus tidyverse packages image
FROM rocker/shiny-verse:latest
# system libraries of general use
RUN apt-get update && apt-get install -y \
sudo \
pandoc \
pandoc-citeproc \
libcurl4-gnutls-dev \
libcairo2-dev \
libxt-dev \
libssl-dev \
libssh2-1-dev \
libpng-dev \
libgdal-dev \
libproj-dev \
libgeos-dev \
libudunits2-dev \
libnode-dev \
libcairo2-dev \
libnetcdf-dev
# install R packages required 
# (change it dependeing on the packages you need)
RUN R -e "install.packages('devtools', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('leaflet', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('dplyr', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('RSQLite', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggplot2', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('showtext', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('Cairo', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('RCurl', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('httr', repos='http://cran.rstudio.com/')"



# copy the app to the image

COPY /inst/app /srv/shiny-server/
  
  # select port
  EXPOSE 3838
# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server
RUN chmod -R 755 /srv/shiny-server/
  # run app
  #CMD ["/usr/bin/shiny-server.sh"]