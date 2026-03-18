import joblib
import os
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# Модельдің толық жолын анықтау (каталогтар шатаспауы үшін)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MODEL_PATH = os.path.join(BASE_DIR, "model.joblib")

# Модельді жүктеу
if os.path.exists(MODEL_PATH):
    model = joblib.load(MODEL_PATH)
else:
    model = None
    print(f"ҚАТЕ: {MODEL_PATH} табылмады!")


@app.get("/")
def home():
    return {"status": "Сервер қосулы", "model_loaded": model is not None}


@app.post("/predict")
def predict(data: dict):
    if model is None:
        return {"error": "Модель жүктелмеген"}

    # Мәліметтерді алу (мысалы: {"features": [5.1, 3.5, 1.4, 0.2]})
    features = data.get("features")
    prediction = model.predict([features])
    return {"prediction": int(prediction[0])}