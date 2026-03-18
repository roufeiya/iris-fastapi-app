FROM python:3.9-slim

WORKDIR /code

# Керекті кітапханаларды орнату
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Кодты және модельді көшіру
# Ескерту: Сенде модель 'app' папкасының ішінде тұрса, жолды солай жазамыз
COPY ./app /code/app
COPY ./app/model.joblib /code/model.joblib

# Портты 8080 жасаймыз (Cloud Run үшін ыңғайлы)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]