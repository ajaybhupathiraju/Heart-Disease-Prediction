import json
import requests

url = "http://127.0.0.1:8087/heartdisease_prediction"
input_data_for_model ={
    "age":40,
    "sex":1,
    "chest_pain_type":2,
    "resting_bp_s":140,
    "cholesterol":289,
    "fasting_blood_sugar":0,
    "resting_ecg":0,
    "max_heart_rate":172,
    "exercise_angina":0,
    "oldpeak":0.0,
    "ST_slope":1,
}
input_json = json.dumps(input_data_for_model)
response = requests.post(url,data=input_json)
print(response.text)