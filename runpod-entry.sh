export HUGGINGFACE_HUB_CACHE="/workspace/data/huggingface-cache/hub"
export TRANSFORMERS_CACHE="/workspace/data/huggingface-cache/hub"
export HF_HOME="/workspace/data/huggingface-cache/hub"

if [ -z "$MODEL_ID" ]; then
    MODEL_ID="stillerman/mtg-aurora"
fi

apt-get update
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
apt-get install unzip
PROTOC_ZIP=protoc-21.12-linux-x86_64.zip
curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v21.12/$PROTOC_ZIP
unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
unzip -o $PROTOC_ZIP -d /usr/local 'include/*'
rm -f $PROTOC_ZIP
apt-get install libssl-dev gcc pkg-config -y

. "$HOME/.cargo/env" && BUILD_EXTENSIONS=True make install

text-generation-launcher --model-id $MODEL_ID