
#export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-30B-A3B-Instruct-FP8/"
#export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-4B-Instruct/snapshots/ebb281ec70b05090aa6165b016eac8ec08e71b17/"
#export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-32B-Instruct/snapshots/0cfaf48183f594c314753d30a4c4974bc75f3ccb/"
export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-30B-A3B-Instruct/snapshots/4b184fbdab8886057d8d80c09f35bcfc65fe640e/"
export DYN_HTTP_PORT=8001
#start NAT
nats-server -js &

export LIP=$(hostname -I | awk '{ print $1 }')
etcd --listen-client-urls http://0.0.0.0:2379 --advertise-client-urls http://${LIP}:2379 --data-dir /tmp/etcd &

sleep 1

#bash ../launch/agg_multimodal.sh --model $MODEL 2>&1 | tee log.txt
bash ../launch/agg_multimodal_epd.sh --model $MODEL 2>&1 | tee log_epd_32.txt &

sleep 5

curl http://localhost:$DYN_HTTP_PORT/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-4B-Instruct/snapshots/ebb281ec70b05090aa6165b016eac8ec08e71b17/",
    "messages": [
      {
        "role": "user",
        "content": [
          {
            "type": "text",
            "text": "图片里有什么?"
          },
          {
            "type": "image_url",
            "image_url": {
              "url": "http://farm6.staticflickr.com/5268/5602445367_3504763978_z.jpg"
            }
          }
        ]
      }
    ],
    "max_tokens": 128
  }'