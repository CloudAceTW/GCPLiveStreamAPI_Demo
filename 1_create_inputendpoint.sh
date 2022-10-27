PROJECT_ID=<YOUR_PROJECT_NAME>
LOCATION=asia-east1
INPUT_ID_1=input-srt-demo
INPUT_ID_2=input-rtmp-demo

cat > input_request_srt.json << 'EOF'
{
  "type": "SRT_PUSH"
}
EOF


cat > input_request_rtmp.json << 'EOF'
{
  "type": "RTMP_PUSH"
}
EOF

echo 
curl -X POST \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H "Content-Type: application/json; charset=utf-8" \
-d @input_request_srt.json \
"https://livestream.googleapis.com/v1/projects/${PROJECT_ID}/locations/${LOCATION}/inputs?inputId=${INPUT_ID_1}"

curl -X POST \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H "Content-Type: application/json; charset=utf-8" \
-d @input_request_rtmp.json \
"https://livestream.googleapis.com/v1/projects/${PROJECT_ID}/locations/${LOCATION}/inputs?inputId=${INPUT_ID_2}"

