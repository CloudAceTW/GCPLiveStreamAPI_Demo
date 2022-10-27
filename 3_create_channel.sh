PROJECT_ID=<YOUR_PROJECT_NAME>
LOCATION=asia-east1
BUCKET_NAME=<YOUR_PROJECT_NAME>-live-demo
INPUT_ID_1=input-srt-demo
INPUT_ID_2=input-rtmp-demo
CHANNEL_ID=channel-hls-demo

cat > channel_request.json << EOF
{
  "inputAttachments": [
    {
      "key": "input-primary",
      "input": "projects/${PROJECT_ID}/locations/${LOCATION}/inputs/${INPUT_ID_1}",
			"automaticFailover": {
        "inputKeys": ["input-backup"]
      }
    },
    {
      "key": "input-backup",
      "input": "projects/${PROJECT_ID}/locations/${LOCATION}/inputs/${INPUT_ID_2}"
    }
  ],
  "output": {
    "uri": "gs://${BUCKET_NAME}"
  },
  "elementaryStreams": [
    {
      "key": "es_video_1080p60",
      "videoStream": {
        "h264": {
          "profile": "high",
          "heightPixels": 1920,
          "widthPixels": 1080,
          "bitrateBps": 3000000,
          "frameRate": 60
        }
      }
    },
    {
      "key": "es_video_720p60",
      "videoStream": {
        "h264": {
          "profile": "high",
          "heightPixels": 720,
          "widthPixels": 1280,
          "bitrateBps": 5500000,
          "frameRate": 60
        }
      }
    },
    {
      "key": "es_audio_160k",
      "audioStream": {
        "codec": "aac",
        "channelCount": 2,
        "bitrateBps": 160000
      }
    },
    {
      "key": "es_audio_64k",
      "audioStream": {
        "codec": "aac",
        "channelCount": 2,
        "bitrateBps": 64000
      }
    }
  ],
  "muxStreams": [
		{
      "key": "mux_video_1080p60",
      "elementaryStreams": [
        "es_video_1080p60"
      ],
      "segmentSettings": {
        "segmentDuration": "2s"
      }
    },
    {
      "key": "mux_video_720p60",
      "elementaryStreams": [
        "es_video_720p60"
      ],
      "segmentSettings": {
        "segmentDuration": "2s"
      }
    },
    {
      "key": "mux_audio_160k",
      "elementaryStreams": [
        "es_audio_160k"
      ],
      "segmentSettings": {
        "segmentDuration": "2s"
      }
    },
    {
      "key": "mux_audio_64k",
      "elementaryStreams": [
        "es_audio_64k"
      ],
      "segmentSettings": {
        "segmentDuration": "2s"
      }
    }
  ],
  "manifests": [
    {
      "fileName": "main.mpd",
      "type": "DASH",
      "muxStreams": [
				"mux_video_1080p60",
        "mux_video_720p60",
        "mux_audio_160k",
        "mux_audio_64k"
      ],
      "maxSegmentCount": 5
    },
    {
      "fileName": "main.m3u8",
      "type": "HLS",
      "muxStreams": [
				"mux_video_1080p60",
        "mux_video_720p60",
        "mux_audio_160k",
        "mux_audio_64k"
      ],
      "maxSegmentCount": 5
    }
  ]
}
EOF

curl -X POST \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H "Content-Type: application/json; charset=utf-8" \
-d @channel_request.json \
"https://livestream.googleapis.com/v1/projects/${PROJECT_ID}/locations/${LOCATION}/channels?channelId=${CHANNEL_ID}"
