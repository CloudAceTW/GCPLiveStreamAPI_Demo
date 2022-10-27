PROJECT_ID=<YOUR_PROJECT_NAME>
LOCATION=asia-east1


echo "#### 列出所有chennel"
curl -X GET \
-H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
"https://livestream.googleapis.com/v1/projects/${PROJECT_ID}/locations/${LOCATION}/channels/"

echo "#### 列出所有input"
curl -X GET \
-H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
"https://livestream.googleapis.com/v1/projects/${PROJECT_ID}/locations/${LOCATION}/inputs/"
