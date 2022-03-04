# syntax=docker/dockerfile:1
FROM phpmyadmin/phpmyadmin

RUN mkdir /cert
COPY ./acme/certs/permgen.dev/permgen.dev.cer /cert/permgen.dev.pem
COPY ./acme/certs/permgen.dev/permgen.dev.key /cert/permgen.dev.key
RUN sed -i 's/^\s.SSLCertificateFile.*/SSLCertificateFile \/cert\/permgen.dev.pem/g' /etc/apache2/sites-available/default-ssl.conf
RUN sed -i 's/^\s.SSLCertificateKeyFile.*/SSLCertificateKeyFile \/cert\/permgen.dev.key/g' /etc/apache2/sites-available/default-ssl.conf
RUN a2ensite default-ssl
RUN a2enmod ssl
RUN service apache2 restart

EXPOSE 443
