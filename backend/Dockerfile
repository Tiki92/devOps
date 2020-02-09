FROM python:3.6.0-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir /backend
WORKDIR /backend

RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

RUN pip install --upgrade pip
ADD requirements.txt /backend/
RUN pip install -r requirements.txt
ADD . /backend/
EXPOSE 8080
