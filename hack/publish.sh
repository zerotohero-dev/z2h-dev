#!/usr/bin/env bash

#   (`-')           (`-').->
#   ( OO).->        (OO )__
# ,(_/----. .----. ,--. ,'-' doubt everything,
# |__,    |\_,-.  ||  | |  |
#  (_/   /    .' .'|  `-'  | be curious,
#  .'  .'_  .'  /_ |  .-.  |
# |       ||      ||  | |  | learn.
# `-------'`------'`--' `--'

mkdocs build

if [[ -z "$Z2H_DEV_S3_BUCKET" || -z "$Z2H_DEV_DISTRIBUTION_ID" ]]; then
  echo "Error: $Z2H_DEV_S3_BUCKET and $Z2H_DEV_DISTRIBUTION_ID must be set."
  exit 1
fi

aws s3 sync site/ "$Z2H_DEV_S3_BUCKET"

aws cloudfront create-invalidation --distribution-id "$Z2H_DEV_DISTRIBUTION_ID" --paths "/*"
