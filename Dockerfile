FROM bmya/odoo:latest
MAINTAINER Blanco Martín & Asociados <daniel@blancomartin.cl>
USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y locales -qq
RUN echo 'es_CL.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
RUN echo 'es_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
RUN echo 'C.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
RUN dpkg-reconfigure locales && /usr/sbin/update-locale LANG=C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y python-pip git vim
RUN apt-get install -y ghostscript  && \
    apt-get install -y python-gevent  && \
    apt-get install -y python-dev freetds-dev  && \
    apt-get install -y python-matplotlib font-manager  && \
    apt-get install -y swig libffi-dev libssl-dev python-m2crypto python-httplib2 mercurial  && \
    apt-get install -y libxml2-dev libxslt-dev python-dev lib32z1-dev liblz-dev  && \
    apt-get install -y swig libssl-dev  && \
    apt-get install -y libcups2-dev 

RUN pip install urllib3
RUN pip install acme-tiny
RUN sudo pip install IPy
RUN pip install psycogreen
RUN pip install pymssql
RUN pip install geopy==0.95.1 BeautifulSoup pyOpenSSL suds cryptography certifi
RUN pip install suds
RUN git clone https://github.com/bmya/pyafipws.git
WORKDIR /pyafipws/
RUN pip install -r requirements.txt
RUN python setup.py install
RUN chmod 777 -R /usr/local/lib/python2.7/dist-packages/pyafipws/
RUN pip install openerp-client-lib fabric erppeek fabtools
RUN pip install xmltodict
RUN pip install dicttoxml
RUN pip install elaphe
RUN pip install cchardet
RUN pip install lxml
RUN pip install signxml
RUN pip install pysftp
RUN pip install xlwt
RUN pip install xlrd
RUN mkdir -p /opt/odoo/stable-addons/oca
RUN mkdir -p /opt/odoo/stable-addons/bmya/odoo-chile
RUN mkdir -p /opt/odoo/.filelocal/odoo
RUN mkdir -p /var/lib/odoo/backups/synced
COPY ./openerp-server.conf /etc/odoo/
RUN chown odoo /etc/odoo/openerp-server.conf
RUN chmod 644 /etc/odoo/openerp-server.conf
RUN chown -R odoo /opt/odoo
RUN chown -R odoo /opt/odoo/stable-addons
RUN chown -R odoo /mnt/extra-addons
RUN chown -R odoo /var/lib/odoo
RUN pip install unicodecsv
RUN pip install git+https://github.com/aeroo/aeroolib.git@master
RUN pip install pycups==1.9.68
RUN pip install BeautifulSoup4
RUN pip install python-magic
RUN pip install SOAPpy
RUN pip install erppeek
WORKDIR /opt/odoo/stable-addons/bmya/
RUN git clone -b 8.0 https://github.com/bmya/sale.git
RUN git clone -b 8.0 https://github.com/bmya/product.git
RUN git clone -b 8.0 https://github.com/bmya/survey.git
RUN git clone -b 8.0 https://github.com/bmya/account-financial-tools.git
RUN git clone -b 8.0 https://github.com/bmya/partner.git
RUN git clone -b 8.0 https://github.com/bmya/stock.git
RUN git clone -b bmya_custom2 https://github.com/bmya/odoo-support.git
RUN git clone -b 8.0 https://github.com/bmya/project.git
RUN git clone -b 8.0 https://github.com/bmya/account-payment.git
RUN git clone -b 8.0 https://github.com/bmya/account-invoicing.git
RUN git clone -b 8.0 https://github.com/bmya/website.git
RUN git clone -b 8.0 https://github.com/bmya/odoo-web.git
RUN git clone -b 8.0 https://github.com/bmya/multi-company.git
RUN git clone -b 8.0 https://github.com/bmya/account-analytic.git
RUN git clone -b 8.0 https://github.com/bmya/purchase.git
RUN git clone -b 8.0 https://github.com/bmya/reporting-engine.git
RUN git clone -b 8.0 https://github.com/bmya/crm.git
RUN git clone -b 8.0 https://github.com/bmya/miscellaneous.git
RUN git clone -b 8.0 https://github.com/bmya/surveyor.git
RUN git clone -b 8.0 https://github.com/bmya/odoo-logistic.git
RUN git clone -b 8.0 https://github.com/bmya/server-tools.git
RUN git clone -b 8.0 https://github.com/bmya/margin-analysis.git
RUN git clone -b 8.0 https://github.com/bmya/pos-addons.git
RUN git clone -b 8.0 https://github.com/bmya/pos.git
# Localización Chilena
RUN git clone -b 8.0 https://github.com/bmya/odoo-bmya-cl.git
# Otras dependencias de BMyA
RUN git clone -b 8.0 https://github.com/bmya/odoo-bmya.git
RUN git clone -b 8.0 https://github.com/bmya/website-addons.git
RUN git clone -b 8.0 https://github.com/bmya/odoo-single-adv.git
RUN git clone -b bmya_custom https://github.com/bmya/tkobr-addons.git tko
RUN git clone https://github.com/bmya/addons-yelizariev.git
RUN git clone https://github.com/bmya/ws-zilinkas.git
WORKDIR /opt/odoo/stable-addons/bmya/odoo-chile/
RUN git clone -b 8.0 https://github.com/odoo-chile/l10n_cl_vat.git
RUN git clone -b 8.0 https://github.com/odoo-chile/base_state_ubication.git
RUN git clone -b 8.0 https://github.com/odoo-chile/decimal_precision_currency.git
RUN git clone -b 8.0 https://github.com/odoo-chile/invoice_printed.git
WORKDIR /opt/odoo/stable-addons/oca/
RUN git clone -b 8.0 https://github.com/OCA/knowledge.git
RUN git clone -b 8.0 https://github.com/OCA/web.git
RUN git clone -b 8.0 https://github.com/OCA/bank-statement-reconcile.git
RUN git clone -b 8.0 https://github.com/OCA/account-invoicing.git
RUN git clone -B 8.0 https://github.com/OCA/e-commerce.git
RUN git clone -B 8.0 https://github.com/OCA/product-attribute.git
RUN git clone -B 8.0 https://github.com/OCA/sale-workflow.git
RUN chown -R odoo:odoo /opt/odoo/stable-addons
WORKDIR /opt/odoo/stable-addons/
RUN git clone -b 8.0 https://github.com/aeroo/aeroo_reports.git
RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python2.7/dist-packages/openerp/addons/im_odoo_support/__openerp__.py
RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python2.7/dist-packages/openerp/addons/bus/__openerp__.py
RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python2.7/dist-packages/openerp/addons/base_import/__openerp__.py
RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python2.7/dist-packages/openerp/addons/portal/__openerp__.py
RUN sed  -i  "s/localhost/aeroo/" /opt/odoo/stable-addons/aeroo_reports/report_aeroo/docs_client_lib.py
RUN sed  -i  "s/localhost/aeroo/" /opt/odoo/stable-addons/aeroo_reports/report_aeroo/installer.py
RUN sed  -i  "s/localhost/aeroo/" /opt/odoo/stable-addons/aeroo_reports/report_aeroo/report_aeroo.py
USER odoo
