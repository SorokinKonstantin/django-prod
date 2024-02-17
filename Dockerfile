FROM python:3.10
ENV PYTHONUNBUFFERED=1
LABEL authors="konstantin"
WORKDIR /mysite
RUN pip install --upgrade pip
RUN pip install "poetry==1.7.1"
RUN poetry config virtualenvs.create false --local
COPY pyproject.toml poetry.lock ./
RUN poetry install
COPY mysite .
RUN python manage.py collectstatic --noinput
CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]
