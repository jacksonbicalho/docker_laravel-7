FROM nginx

ARG SERVER_NAME
ARG DIR_BASE
ARG SERVER_ROOT

COPY ./certs/gen-certs.sh /etc/ssl/certs/
RUN chmod +x /etc/ssl/certs/gen-certs.sh
RUN ./etc/ssl/certs/gen-certs.sh ${SERVER_NAME}

COPY ./conf.d/app.conf /etc/nginx/conf.d/app.conf

RUN sed -i.bak "s|SERVER_NAME|${SERVER_NAME}|g" /etc/nginx/conf.d/app.conf
RUN sed -i.bak "s|SERVER_ROOT|${SERVER_ROOT}|g" /etc/nginx/conf.d/app.conf

WORKDIR $DIR_BASE