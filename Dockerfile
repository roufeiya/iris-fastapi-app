FROM python:3.9-slim

WORKDIR /code

# Керекті кітапханаларды орнату
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Модель мен кодты контейнерге көшіру
COPY ./model.joblib /code/model.joblib
COPY ./app /code/app

# Серверді іске қосу (порт 8080 Render үшін стандарт)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
