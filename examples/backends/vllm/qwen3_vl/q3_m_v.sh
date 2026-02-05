export MODEL="Qwen/Qwen3-VL-30B-A3B-Instruct"
VLLM_ALLOW_LONG_MAX_MODEL_LEN=1 \
VLLM_WORKER_MULTIPROC_METHOD=spawn \
VLLM_OFFLOAD_WEIGHTS_BEFORE_QUANT=1 \
python3 -m vllm.entrypoints.openai.api_server \
--model $MODEL \
--served-model-name $MODEL\
--dtype=float16 \
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
--quantization fp8 \
-tp=2