import requests
import boto3

def lambda_handler(event, context):
    URL = "https://rb.gy/ecsbx7"
    response = requests.get(URL)
    open("/tmp/lade.jpg", "wb").write(response.content)
    s3 = boto3.resource('s3')
    BUCKET = "lade-sbucket"
    s3.Bucket(BUCKET).upload_file("/tmp/lade.jpg", "lade.jpg")