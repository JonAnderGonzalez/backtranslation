#!/bin/bash

DATA=./data/prepared

LANGUAGE=$1
SIZE=$2

#spaces to separate the tokens. 
fairseq-preprocess \
    --only-source \
    --joined-dictionary \
    --tokenizer=space \
    --source-lang="${LANGUAGE}.inflected" \
    --target-lang="${LANGUAGE}.lemma_tag" \
    --srcdict="data-bin/${SIZE}/dict.${LANGUAGE}.inflected.txt" \
    --testpref=${DATA}/gen/${SIZE}/bt \
    --destdir="data-bin/${SIZE}/bt"; \
    
    cp data-bin/${SIZE}/dict.${LANGUAGE}.lemma_tag.txt data-bin/${SIZE}/bt/dict.${LANGUAGE}.lemma_tag.txt;
    