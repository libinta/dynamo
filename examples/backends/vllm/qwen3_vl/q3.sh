#export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-30B-A3B-Instruct-FP8/"
#export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-32B-Instruct-FP8/snapshots/4bf2c2f39c37c0fede78bede4056e1f18cdf8109/ "
export MODEL="/software/data/pytorch/huggingface/hub/models--Qwen--Qwen3-VL-4B-Instruct/snapshots/ebb281ec70b05090aa6165b016eac8ec08e71b17/"
#export VLLM_OFFLOAD_WEIGHTS_BEFORE_QUANT=1
VLLM_ALLOW_LONG_MAX_MODEL_LEN=1 \
VLLM_WORKER_MULTIPROC_METHOD=spawn \
python3 -m vllm.entrypoints.openai.api_server \
    --model $MODEL \
    --served-model-name $MODEL \
    --dtype=bfloat16  \
    --enforce-eager \
    --port 8000 \
    --host 0.0.0.0 \
    --trust-remote-code \
    --gpu-memory-util=0.9 \
    --no-enable-prefix-caching \
    --max-num-batched-tokens=8192 \
    --disable-log-requests \
    --max-model-len=8192 \
    --block-size 64 \
    -tp=1 2>&1 | tee log_q3.txt