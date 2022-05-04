FROM bitnami/apache

USER 0
RUN install_packages apt-utils \
    && install_packages gcc \
    && install_packages make \
    && install_packages libc6-dev \
    && install_packages default-libmysqlclient-dev \
    && install_packages mariadb-client \
    && install_packages perl \
    && install_packages libcgi-session-perl

RUN cd ~/bin \
    && curl -L https://cpanmin.us/ -o cpanm \
    && chmod +x cpanm

RUN cpanm Canary::Stability \
    && cpanm JSON \
    && cpanm Moose \
    && cpanm DBI \
    && cpanm DBD::mysql

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

USER 1001

ENTRYPOINT [ "/docker-entrypoint.sh", "/opt/bitnami/scripts/apache/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/apache/run.sh" ]