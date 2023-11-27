import pandas as pd
import joblib
from application.repository.repository import PredictionRepository
from application.model.model import Prediction

def predictBusiness(data):
    try:
        try:
            nb = joblib.load('nb.pkl')
        except Exception as e:
            return str(e)
        
        df = pd.DataFrame([data])
        sample = transformData(pd.DataFrame([data]))

        array = sample.values
        new_data = array[:,0:10]
        prediction = nb.predict(new_data)

        df['stroke'] = transformStroke(prediction[0])
        prediction_object = Prediction(
            name=df['name'].values[0],
            phone=df['phone'].values[0],
            gender=df['gender'].values[0],
            age=df['age'].values[0].item(),
            hypertension=df['hypertension'].values[0].item(),
            heart_disease=df['heart_disease'].values[0].item(),
            ever_married=df['ever_married'].values[0],
            work_type=df['work_type'].values[0],
            residence_type=df['residence_type'].values[0],
            avg_glucose_level=df['avg_glucose_level'].values[0].item(),
            bmi=df['bmi'].values[0].item(),
            smoking_status=df['smoking_status'].values[0],
            stroke=df['stroke'].values[0]
        )
        repository = PredictionRepository()

        try:
            repository.insert(data=prediction_object)
            response = int(prediction[0].item())
        except Exception as e:
            return str(e)
        
        return response
    
    except Exception as e:
        return str(e)

def transformData(data):

    gender = {'Male': 1, 'Female': 2}
    ever_married = {'No': 0, 'Yes': 1}
    work_type = {'Never_worked': 1, 'Private': 2, 'Govt_job': 3, 'Self-employed': 4}
    residence_type = {'Rural': 1, 'Urban': 2}
    smoking_status = {'never smoked': 1, 'formerly smoked': 2, 'smokes': 3, 'Unknown': 4}

    data = data.drop(columns=['name', 'phone'])
    data['gender'] = data['gender'].map(gender)
    data['ever_married'] = data['ever_married'].map(ever_married)
    data['work_type'] = data['work_type'].map(work_type)
    data['residence_type'] = data['residence_type'].map(residence_type)
    data['smoking_status'] = data['smoking_status'].map(smoking_status)

    return data

def transformStroke(prediciton_stroke):
    if prediciton_stroke == 1:
        stroke = 'Stroke'
    elif prediciton_stroke == 0:
        stroke = 'No Stroke'
    return stroke

def predictionBusiness(prediction_id=0):
    select_predictions = PredictionRepository()
    if prediction_id == 0:
        prediction = select_predictions.select_predictions()
    else:
        prediction = select_predictions.select_prediction_id(prediction_id)

    columns = ['name', 'phone', 'gender', 'age', 'hypertension', 'heart_disease', 'ever_married', 'work_type', 'residence_type', 'avg_glucose_level', 'bmi', 'smoking_status', 'stroke']
    predictionById = [dict(zip(columns, row)) for row in prediction]
    return predictionById