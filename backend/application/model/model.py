from pydantic import BaseModel

class Prediction(BaseModel):
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
   stroke: str