#!/bin/bash

SEED=42

LANGUAGE=$1
SIZE=$2
INPUT=$3
OUTPUT=$4

fairseq-generate data-bin/${SIZE} \
    --source-lang="${LANGUAGE}.${INPUT}" \
    --target-lang="${LANGUAGE}.${OUTPUT}" \
    --path checkpoints/${LANGUAGE}/${SIZE}/${OUTPUT}/checkpoint_best.pt \
    --results-path generated/${LANGUAGE}/${SIZE}/${OUTPUT} \
    --batch-size 128 --beam 5; \
    
    grep ^S generated/${LANGUAGE}/${SIZE}/${OUTPUT}/generate-test.txt | LC_ALL=C sort -V | cut -f2- > generated/${LANGUAGE}/${SIZE}/${OUTPUT}/sen.txt; \
    grep ^H generated/${LANGUAGE}/${SIZE}/${OUTPUT}/generate-test.txt | LC_ALL=C sort -V | cut -f3- > generated/${LANGUAGE}/${SIZE}/${OUTPUT}/hyp.txt;