FROM jarvice/ubuntu-ibm-mldl-ppc64le

# uprev to force rebuild even if cached
ENV APP_POWERAI_VERSION 1

ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh && rm -f /tmp/install-ubuntu.sh

RUN pip install pandas_datareader && \
    pip install httplib2 && \
    pip install watson_developer_cloud && \
    apt-get -y install build-essential libssl-dev libffi-dev python-dev && \
    pip install quandl && \
    apt-get -y install python-matplotlib && \
    pip install nytimesarticle && \
    apt-get -y install python-lxml && \
    pip install cython && \
    apt-get -y install python-scipy && \
    pip install scikit-learn && \
    apt-get -y install libxml2-dev libxmlsec1-dev && \
    pip install dragnet && \
    apt-get clean

COPY NAE/help.html /etc/NAE/help.html
COPY NAE/screenshot.png /etc/NAE

COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

WORKDIR /usr/local/samples
RUN git clone https://github.com/fbarilla/MLDL-demo.git

COPY scripts/sample_notebook.sh /usr/local/scripts/sample_notebook.sh
