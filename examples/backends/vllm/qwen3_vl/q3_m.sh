export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-30B-A3B-Instruct-FP8/"
#export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-32B-Instruct-FP8/snapshots/4bf2c2f39c37c0fede78bede4056e1f18cdf8109/ "
#export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-4B-Instruct/snapshots/ebb281ec70b05090aa6165b016eac8ec08e71b17/"
#export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-32B-Instruct/snapshots/0cfaf48183f594c314753d30a4c4974bc75f3ccb/"
#export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-30B-A3B-Instruct/snapshots/4b184fbdab8886057d8d80c09f35bcfc65fe640e/"
VLLM_OFFLOAD_WEIGHTS_BEFORE_QUANT=1
VLLM_ALLOW_LONG_MAX_MODEL_LEN=1 \
VLLM_WORKER_MULTIPROC_METHOD=spawn \
python -m dynamo.vllm --enable-multimodal --model $MODEL --served-model-name $MODEL --connector none --enforce-eager --dtype float16 --block-size 64 --max-model-len 8192 --gpu-memory-utilization 0.7  2>&1 | tee log_q3_m.txt