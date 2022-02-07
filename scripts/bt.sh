#!/bin/bash

SEED=42

LANGUAGE=$1
SIZE=$2

fairseq-generate data-bin/${SIZE}/bt \
    --source-lang="${LANGUAGE}.inflected" \
    --target-lang="${LANGUAGE}.lemma_tag" \
    --path checkpoints/${LANGUAGE}/${SIZE}/lemma_tag/checkpoint_best.pt \
    --results-path generated/${LANGUAGE}/${SIZE}/bt/lemma_tag \
    --batch-size 128 --beam 5; \
    grep ^S generated/${LANGUAGE}/${SIZE}/bt/lemma_tag/generate-test.txt | LC_ALL=C sort -V | cut -f2- > ./data/prepared/${SIZE}/train.bt.${LANGUAGE}.inflected; \
    grep ^H generated/${LANGUAGE}/${SIZE}/bt/lemma_tag/generate-test.txt | LC_ALL=C sort -V | cut -f3- > ./data/prepared/${SIZE}/train.bt.${LANGUAGE}.lemma_tag; \
    cat ./data/prepared/${SIZE}/train.${LANGUAGE}.lemma_tag; >> ./data/prepared/${SIZE}/train.bt.${LANGUAGE}.lemma_tag; \
    cat ./data/prepared/${SIZE}/train.${LANGUAGE}.inflected; >> ./data/prepared/${SIZE}/train.bt.${LANGUAGE}.inflected;
    