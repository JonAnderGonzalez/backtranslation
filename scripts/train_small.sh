#!/bin/bash

SEED=42
DATABIN=data-bin
CKPTS=checkpoints
LOGDIR=logs

LANGUAGE=$1
INPUT=$2
OUTPUT=$3
#parameters from best performing model at SIGMORPHON 2020:

# Encoder/decoder embedding dim.
ED=256
# Encoder/decoder hidden layer size.
HS=1024
# Encoder/decoder number of layers.
NL=4
# Encoder/decoder number of attention heads.
AH=4
# Dropout
DP=0.3

# Batch size changed for faster training
BS=32
# Max-update
MU=120000
# Warmup update
WU=4000
# Learning rate
LR=0.001
# Label smoothing
LS=0.1
# clip-norm
CN=1.0
#optimizer
OP=adam
#adam-betas
AB='(0.9, 0.98)'
#activation function
AF=relu
#loss function
LF=label_smoothed_cross_entropy
#patience, added for faster training
P=50

fairseq-train "${DATABIN}/low" \
	      --task=translation \
	      --source-lang="${LANGUAGE}.${INPUT}" \
	      --target-lang="${LANGUAGE}.${OUTPUT}" \
	      --save-dir="${CKPTS}/${LANGUAGE}/low/${OUTPUT}" \
	      --tensorboard-logdir="${LOGDIR}/${LANGUAGE}/low/${OUTPUT}" \
	      --dropout="${DP}" \
	      --attention-dropout="${DP}" \
	      --activation-dropout="${DP}" \
	      --arch=transformer \
	      --activation-fn=${AF} \
	      --encoder-embed-dim="${ED}" \
	      --encoder-ffn-embed-dim="${HS}" \
	      --encoder-layers="${NL}" \
	      --encoder-attention-heads="${AH}" \
	      --encoder-normalize-before \
	      --decoder-embed-dim="${ED}" \
	      --decoder-ffn-embed-dim="${HS}" \
	      --decoder-layers="${NL}" \
	      --decoder-attention-heads="${AH}" \
	      --decoder-normalize-before \
	      --share-decoder-input-output-embed \
	      --optimizer=${OP} \
	      --adam-betas='(0.9, 0.98)' \
	      --clip-norm="${CN}" \
	      --lr="${LR}" \
	      --lr-scheduler=inverse_sqrt \
	      --warmup-updates="${WU}" \
	      --criterion=${LF} \
	      --label-smoothing="${LS}" \
	      --batch-size="${BS}" \
	      --max-update="${MU}" \
	      --no-epoch-checkpoints \
	      --patience="${P}" \
	      --seed="${SEED}"

