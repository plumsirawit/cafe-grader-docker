# Base image
FROM nginx
# Install dependencies
RUN apt-get update -qq && apt-get -y install apache2-utils
# establish where Nginx should look for files
ENV RAILS_ROOT /cafe_grader/web
# Set our working directory inside the image
WORKDIR $RAILS_ROOT
# Copy Nginx config template
# [6/2/2020] Use external nginx config but with bind volumes
# substitute variable references in the Nginx config template for real values from the environment 
# put the final config in its place
# [6/2/2020] Use external nginx config but with bind volumes
# -- RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf
EXPOSE 443 
# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
