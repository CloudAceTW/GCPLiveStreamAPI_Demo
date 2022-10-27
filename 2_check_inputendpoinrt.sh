PROJECT_ID=<YOUR_PROJECT_NAME>
LOCATION=asia-east1

curl -X GET \
-H "Authorization: Bearer "$(gcloud auth print-access-token) \
"https://livestream.googleapis.com/v1/projects/${PROJECT_ID}/locations/${LOCATION}/inputs/"
