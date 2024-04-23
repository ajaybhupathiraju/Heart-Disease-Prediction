# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import uvicorn
from fastapi import FastAPI
from pydantic import BaseModel
import pickle 
import json
import sklearn


app = FastAPI()

class ModelInput(BaseModel):
      age : int
      sex : int
      chest_pain_type : int
      resting_bp_s : int 
      cholesterol  : int 
      fasting_blood_sugar : int 
      resting_ecg : int 
      max_heart_rate : int 
      exercise_angina : int 
      oldpeak : int 
      ST_slope : int 
    
      
# load model
model = pickle.load(open("C:\\Users\\q833597\\OneDrive - IQVIA\\Desktop\\deployee_ml\\hdmodel.pkl","rb"))

@app.post('/heartdisease_prediction')
def heartdisease_pred(input_parameters : ModelInput):
    input_data = input_parameters.json()
    input_dictionary = json.loads(input_data)
    
    age = input_dictionary['age']
    sex = input_dictionary['sex']
    chest_pain_type = input_dictionary['chest_pain_type']
    resting_bp_s = input_dictionary['resting_bp_s']
    cholesterol = input_dictionary['cholesterol']
    fasting_blood_sugar = input_dictionary['fasting_blood_sugar']
    resting_ecg = input_dictionary['resting_ecg']
    max_heart_rate = input_dictionary['max_heart_rate']
    exercise_angina = input_dictionary['exercise_angina']
    oldpeak = input_dictionary['oldpeak']
    ST_slope = input_dictionary['ST_slope']
    
    input_list = [age,sex,chest_pain_type,resting_bp_s,cholesterol,fasting_blood_sugar,resting_ecg,max_heart_rate,exercise_angina,oldpeak,ST_slope]
    
    
    prediction = model.predict([input_list])[0]
    
    if prediction == 0:
       return 'person with no heart disease'
    else:
       return 'person with heart disease'


if __name__=="__main__":
    uvicorn.run(app,port=8087,host="127.0.0.1")