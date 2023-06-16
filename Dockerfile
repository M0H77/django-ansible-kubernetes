# pull official base image
FROM python:3.9.6-alpine

ENV PYTHONUNBUFFERED 1

# set work directory
WORKDIR /code

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy project
COPY ./djangoApp ./djangoApp

EXPOSE 8000

# runs the production server
CMD ["python", "djangoApp/manage.py", "runserver", "0.0.0.0:8000"]