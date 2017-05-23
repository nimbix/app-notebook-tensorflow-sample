FROM jarvice/ubuntu-ibm-mldl-ppc64le

# uprev to force rebuild even if cached
ENV APP_POWERAI_VERSION 1

ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh && rm -f /tmp/install-ubuntu.sh

RUN apt-get -y install build-essential libssl-dev libffi-dev python-dev python-matplotlib python-lxml python-scipy libxml2-dev libxmlsec1-dev && apt-get clean
RUN pip install pandas_datareader && \
    pip install httplib2 && \
    pip install watson_developer_cloud && \
    pip install quandl && \
    pip install nytimesarticle && \
    pip install cython && \
    pip install scikit-learn && \
    pip install dragnet

COPY NAE/help.html /etc/NAE/help.html
COPY NAE/screenshot.png /etc/NAE

COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

WORKDIR /usr/local/samples
RUN git clone https://github.com/fbarilla/MLDL-demo.git

COPY scripts/sample_notebook.sh /usr/local/scripts/sample_notebook.sh
