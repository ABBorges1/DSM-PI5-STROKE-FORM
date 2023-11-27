# Importe as bibliotecas necessárias
from flask import Blueprint, jsonify, request, abort
from pydantic import BaseModel, ValidationError
from application.business.business import predictBusiness, predictionBusiness
from application.repository.repository import PredictionRepository

app_blueprint = Blueprint('app', __name__)

class RequestPayload(BaseModel):
    name: str
    phone: str
    gender: str
    age: float
    hypertension: int
    heart_disease: int
    ever_married: str
    work_type: str
    residence_type: str
    avg_glucose_level: float
    bmi: float
    smoking_status: str

@app_blueprint.route('/predict', methods=['POST'])
def predict():
    
    try:
        payload = RequestPayload(**request.json)
        data = payload.dict()
        response = predictBusiness(data)
        return jsonify(response)

    except ValidationError as e:
        return jsonify({'error': str(e)}),

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app_blueprint.route('/prediction', methods=['GET'])
def prediction():
    predicitions = predictionBusiness()
    return jsonify(predicitions)

@app_blueprint.route('/prediction/<int:prediction_id>', methods=['GET'])
def predictionById(prediction_id):
    prediction = predictionBusiness(prediction_id)
    if prediction:
        return jsonify(prediction)
    else:
        abort(404, description=f"Prediction with ID {prediction_id} not found")