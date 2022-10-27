PROJECT_ID=<YOUR_PROJECT_NAME>
LOCATION=asia-east1
CHANNEL_ID=channel-hls-demo

curl -X POST \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H "Content-Type: application/json; charset=utf-8" \
-d "" \
"https://livestream.googleapis.com/v1/projects/${PROJECT_ID}/locations/${LOCATION}/channels/${CHANNEL_ID}:start"
