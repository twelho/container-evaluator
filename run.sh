#!/bin/sh -ex
# Set ACCOUNT before running this script

# We want to run this interactively
srun \
    --time=00:10:00 \
    --account="${ACCOUNT:-undefined}" \
    --partition=small \
    ./evaluator.sh
