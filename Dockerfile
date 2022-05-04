FROM bitnami/apache

USER 0
RUN install_packages apt-utils \
    && install_packages gcc \
    && install_packages make \
    && install_packages libc6-dev \
    && install_packages perl \
    && install_packages libcgi-session-perl 

RUN cd ~/bin \
    && curl -L https://cpanmin.us/ -o cpanm \
    && chmod +x cpanm

RUN cpanm Canary::Stability \
    && cpanm JSON \
    && cpanm Moose

USER 1001