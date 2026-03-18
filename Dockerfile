FROM python:3.9-slim

WORKDIR /code

# Библиотекаларды орнату
COPY ./app/requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Файлдарды көшіру
COPY ./model.joblib /code/model.joblib
COPY ./app/main.py /code/app/main.py

# Серверді қосу
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
