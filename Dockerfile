FROM bitnami/apache

USER 0
RUN install_packages apt-utils \
    && install_packages make \
    && install_packages perl \
    && install_packages libcgi-session-perl \
    && cd ~/bin \
    && curl -L https://cpanmin.us/ -o cpanm \
    && chmod +x cpanm \
    && /bin/cpanm Canary::Stability \
    && /bin/cpanm JSON 

USER 1001