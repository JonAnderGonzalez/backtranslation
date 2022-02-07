#!/bin/bash

SEED=42

LANGUAGE=$1
SIZE=$2

fairseq-generate data-bin/${SIZE}/new \
    --source-lang="${LANGUAGE}.lemma_tag" \
    --target-lang="${LANGUAGE}.inflected" \
    --path checkpoints/${LANGUAGE}/${SIZE}/inflected/bt/checkpoint_best.pt \
    --results-path generated/${LANGUAGE}/${SIZE}/inflected/bt \
    --batch-size 128 --beam 5; \
    
    grep ^S generated/${LANGUAGE}/${SIZE}/inflected/bt/generate-test.txt | LC_ALL=C sort -V | cut -f2- > generated/${LANGUAGE}/${SIZE}/inflected/bt/sen.txt; \
    grep ^H generated/${LANGUAGE}/${SIZE}/inflected/bt/generate-test.txt | LC_ALL=C sort -V | cut -f3- > generated/${LANGUAGE}/${SIZE}/inflected/bt/hyp.txt;