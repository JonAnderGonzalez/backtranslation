#!/bin/bash

DATA=./data/prepared

LANGUAGE=$1
SIZE=$2

#spaces to separate the tokens. 
fairseq-preprocess \
    --joined-dictionary \
    --tokenizer=space \
    --source-lang="${LANGUAGE}.lemma_tag" \
    --target-lang="${LANGUAGE}.inflected" \
    --trainpref=${DATA}/${SIZE}/train.bt \
    --validpref=${DATA}/dev/dev \
    --testpref=${DATA}/test/test \
    --destdir="data-bin/${SIZE}/new" \
    --thresholdsrc=0 \
    --thresholdtgt=0