FROM python:2-alpine3.7

COPY . /sygnal
WORKDIR /sygnal
RUN mkdir var

RUN apk add --no-cache --virtual build-base \
 && pip install --upgrade pip \
 && pip install gunicorn \
 && pip install . \
 && apk del --purge build-base

COPY ./gunicorn_config.py.sample /sygnal/gunicorn_config.py
COPY ./sygnal.conf.sample /sygnal/sygnal.conf

EXPOSE 5000/tcp
CMD ["gunicorn", "-c", "gunicorn_config.py", "sygnal:app"]